import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import '../transactions/envelope_picker.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'goal_texts.dart';

/// Screen 24 Mover dinero (FR-25): money from one envelope to another inside
/// the month, without a transaction. "Desde" is the envelope the screen was
/// opened from; both cards open the envelope picker 36. When the destination is
/// overspent the amount starts as its overspending, capped at what the source
/// has. The `SaveBar` stays Disabled with the reason until the move is valid;
/// the API has the last word (`409` when the money changed meanwhile).
class MoveMoneyPage extends StatefulWidget {
  const MoveMoneyPage({
    required this.fromEnvelopeId,
    required this.plans,
    required this.envelopes,
    super.key,
  });

  final String fromEnvelopeId;
  final PlansController plans;
  final EnvelopesController envelopes;

  @override
  State<MoveMoneyPage> createState() => _MoveMoneyPageState();
}

class _MoveMoneyPageState extends State<MoveMoneyPage> {
  late String _fromId = widget.fromEnvelopeId;
  String? _toId;
  int _amountMinor = 0;
  bool _saving = false;

  Currency get _currency => widget.plans.currency;

  EnvelopeLineData? get _from => widget.envelopes.lineById(_fromId);
  EnvelopeLineData? get _to =>
      _toId == null ? null : widget.envelopes.lineById(_toId!);

  /// Amount that covers the destination's overspending, capped at what the
  /// source has; 0 when there is nothing to cover.
  int get _cover {
    final to = _to;
    final from = _from;
    if (to == null || from == null || to.availableMinor >= 0) return 0;
    return math.min(-to.availableMinor, math.max(0, from.availableMinor));
  }

  String? get _blocker {
    final from = _from;
    if (from == null || _to == null) return 'Elegí un sobre';
    if (_amountMinor <= 0) return 'Ingresá un monto';
    if (_amountMinor > from.availableMinor) return 'Supera lo disponible';
    return null;
  }

  Future<void> _pick({required bool source}) async {
    final other = source ? _toId : _fromId;
    final pick = await showEnvelopePicker(
      context,
      envelopes: widget.envelopes,
      currency: _currency,
      selectedId: source ? _fromId : _toId,
      exclude: {?other},
    );
    if (pick is! EnvelopeChosen) return;
    setState(() {
      if (source) {
        _fromId = pick.envelopeId;
      } else {
        _toId = pick.envelopeId;
      }
      // The amount follows the destination's overspending until typed by hand.
      _amountMinor = _cover > 0 ? _cover : _amountMinor;
    });
  }

  Future<void> _editAmount() async {
    final minor = await showAmountSheet(
      context,
      title: 'Monto a mover',
      currency: _currency,
      initialMinor: _amountMinor,
    );
    if (minor != null) setState(() => _amountMinor = minor);
  }

  Future<void> _save() async {
    if (_saving || _blocker != null) return;
    if (!(widget.plans.activePlan?.canEdit ?? false)) {
      showForbidden(context);
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.envelopes.moveMoney(
        fromEnvelopeId: _fromId,
        toEnvelopeId: _toId!,
        amountMinor: _amountMinor,
      );
      if (!mounted) return;
      showSaved(context, 'Guardado');
      context.pop();
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.conflict:
          showUiToast(
            context,
            variant: UiToastVariant.warning,
            title: 'Ya no hay tanto disponible',
            detail: 'Revisá el monto e intentá de nuevo.',
          );
          // The figures changed meanwhile: show the real ones.
          await widget.envelopes.load();
        case ApiFailureKind.forbidden:
          showForbidden(context);
        default:
          showConnectionProblem(context);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _card(EnvelopeLineData? line, {required bool source}) {
    void onTap() => _pick(source: source);
    if (line == null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: UiCard(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Elegí un sobre',
                  style: UiTypography.custom(18, color: UiColors.inkMuted),
                ),
              ),
              const Icon(UiIcons.chevronRight, size: 20, color: UiColors.ink),
            ],
          ),
        ),
      );
    }
    final spent = math.max(0, line.spentMinor);
    return UiEnvelopeRow(
      variant: rowVariant(line),
      icon: uiEnvelopeIcon(line.envelope.icon),
      name: line.envelope.name,
      subtitle:
          '${formatMoney(spent, _currency)} de '
          '${formatMoney(line.assignedMinor, _currency)}',
      amount: formatMoney(line.availableMinor, _currency),
      caption: rowCaption(line, _currency),
      progress: rowProgress(line),
      onTap: onTap,
    );
  }

  List<int> get _quick {
    final base = _currency == Currency.ars
        ? const [10000, 20000]
        : const [50, 100];
    final factor = math.pow(10, _currency.minorUnits).toInt();
    return [
      if (_cover > 0) _cover,
      for (final value in base)
        if (value * factor != _cover) value * factor,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.envelopes,
      builder: (context, _) {
        final blocker = _blocker;
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: UiIconButton(
                    icon: UiIcons.close,
                    variant: UiIconButtonVariant.soft,
                    semanticLabel: 'Cerrar',
                    onPressed: () => context.pop(),
                  ),
                ),
                const SizedBox(height: 14),
                Text('Mover dinero', style: UiTypography.custom(36)),
                const SizedBox(height: 22),
                Text(
                  'Desde',
                  style: UiTypography.custom(17, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 10),
                _card(_from, source: true),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Icon(
                      UiIcons.arrowDown,
                      size: 22,
                      color: UiColors.inkMuted,
                    ),
                  ),
                ),
                Text(
                  'Hacia',
                  style: UiTypography.custom(17, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 10),
                _card(_to, source: false),
                const SizedBox(height: 22),
                Center(
                  child: Semantics(
                    button: true,
                    label: 'Cambiar el monto a mover',
                    child: GestureDetector(
                      onTap: _editAmount,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: UiAmountCapsule(
                          symbol: _currency.symbol,
                          value: formatAmountValue(_amountMinor, _currency),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final minor in _quick)
                      UiChip(
                        label: formatAmountValue(minor, _currency),
                        selected: minor == _amountMinor,
                        onPressed: () => setState(() => _amountMinor = minor),
                      ),
                  ],
                ),
                const SizedBox(height: 22),
                UiSaveBar(
                  label:
                      blocker ??
                      'Mover ${formatMoney(_amountMinor, _currency)}',
                  enabled: blocker == null && !_saving,
                  onConfirm: _save,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
