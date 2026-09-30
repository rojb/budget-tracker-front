import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'faded_scroll.dart';

/// Screen 46 Asigná tu dinero: distributes the plan's money among the new
/// envelopes in one go (the initial bulk assignment). Over-assigning is
/// reported, not blocked.
class AssignMoneyPage extends StatefulWidget {
  const AssignMoneyPage({
    required this.plans,
    required this.envelopes,
    super.key,
  });

  final PlansController plans;
  final EnvelopesController envelopes;

  @override
  State<AssignMoneyPage> createState() => _AssignMoneyPageState();
}

class _AssignMoneyPageState extends State<AssignMoneyPage> {
  final Map<String, int> _amounts = {};
  bool _saving = false;

  Currency get _currency => widget.plans.currency;

  /// Money to distribute: what is left to assign plus what the envelopes
  /// already have assigned this month.
  int get _total =>
      widget.envelopes.readyToAssignMinor +
      widget.envelopes.lines.fold(0, (sum, l) => sum + l.assignedMinor);

  int _amountOf(EnvelopeLineData line) =>
      _amounts[line.envelope.id] ?? line.assignedMinor;

  int get _remaining =>
      _total - widget.envelopes.lines.fold(0, (sum, l) => sum + _amountOf(l));

  Future<void> _edit(EnvelopeLineData line) async {
    final value = await showAmountSheet(
      context,
      title: line.envelope.name,
      currency: _currency,
      initialMinor: _amountOf(line),
    );
    if (value != null) setState(() => _amounts[line.envelope.id] = value);
  }

  Future<void> _done() async {
    if (_saving) return;
    final changes = {
      for (final line in widget.envelopes.lines)
        if (_amountOf(line) != line.assignedMinor)
          line.envelope.id: _amountOf(line),
    };
    if (changes.isEmpty) {
      context.go(AppRoutes.plan);
      return;
    }
    setState(() => _saving = true);
    try {
      final result = await widget.envelopes.assignInitial(changes);
      if (!mounted) return;
      context.go(AppRoutes.plan);
      if (result.readyToAssignMinor < 0) {
        showUiToast(
          context,
          variant: UiToastVariant.warning,
          title: 'Asignaste más de lo disponible',
          detail: 'Listo para asignar quedó en negativo.',
          bottomOffset: 100,
        );
      }
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  List<Widget> _rows(String label, List<EnvelopeLineData> lines) => [
    UiSectionLabel(label),
    for (final line in lines)
      UiEnvelopeAmountRow(
        icon: uiEnvelopeIcon(line.envelope.icon),
        name: line.envelope.name,
        amount: formatMoney(_amountOf(line), _currency),
        assigned: _amountOf(line) > 0,
        onTap: () => _edit(line),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    final envelopes = widget.envelopes;
    final remaining = _remaining;
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([envelopes, widget.plans]),
          builder: (context, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: UiIconButton(
                      icon: UiIcons.close,
                      variant: UiIconButtonVariant.soft,
                      semanticLabel: 'Cerrar',
                      onPressed: () => context.go(AppRoutes.plan),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('Asigná tu dinero', style: UiTypography.custom(34)),
                  const SizedBox(height: 6),
                  Text(
                    'Repartí lo que tenés entre tus sobres nuevos.',
                    style: UiTypography.custom(16, color: UiColors.inkMuted),
                  ),
                  const SizedBox(height: 16),
                  UiCard(
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatMoney(_total, _currency),
                          style: UiTypography.display,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Listo para asignar',
                          style: UiTypography.custom(
                            15,
                            color: UiColors.inkMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FadedScroll(
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 40),
                        children: [
                          for (final group in envelopes.groups)
                            if (envelopes.linesOf(group.id).isNotEmpty)
                              ..._rows(group.name, envelopes.linesOf(group.id)),
                          if (envelopes.linesOf(null).isNotEmpty)
                            ..._rows('Sin grupo', envelopes.linesOf(null)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        Icon(
                          remaining < 0 ? UiIcons.warning : UiIcons.info,
                          size: 20,
                          color: UiColors.inkMuted,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            remaining < 0
                                ? 'Te pasaste ${formatMoney(-remaining, _currency)}'
                                : 'Te quedan ${formatMoney(remaining, _currency)} '
                                      'por asignar',
                            style: UiTypography.custom(
                              15,
                              color: UiColors.inkMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UiButton(
                    label: 'Listo',
                    icon: UiIcons.check,
                    loading: _saving,
                    onPressed: _done,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
