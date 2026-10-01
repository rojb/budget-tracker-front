import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import '../common/months.dart';
import '../plans/plans_controller.dart';
import 'month_controller.dart';
import 'month_keys.dart';
import 'months_repository.dart';

/// Screen 25 Cierre de mes: how the plan looks when [fromMonth] closes (FR-11,
/// FR-12). Positive Available carries over, overspending is deducted from the
/// next month's Ready to Assign and those envelopes restart at $ 0; the "Todo
/// cuadra" card checks Σ cuentas − Σ disponible − reservado a futuro = Listo
/// para asignar with the next month's figures. It opens by itself from the
/// plan view (a system trigger, PRD-ux-spec.md §9.3); "Empezar octubre" confirms
/// it and the close button leaves it pending.
class MonthClosePage extends StatefulWidget {
  const MonthClosePage({
    required this.fromMonth,
    required this.plans,
    required this.month,
    this.initial,
    super.key,
  });

  /// "2026-09".
  final String fromMonth;
  final PlansController plans;
  final MonthController month;

  /// The close already loaded by the plan view; loaded here when null.
  final MonthCloseData? initial;

  @override
  State<MonthClosePage> createState() => _MonthClosePageState();
}

class _MonthClosePageState extends State<MonthClosePage> {
  MonthCloseData? _close;
  bool _failed = false;
  bool _saving = false;

  Currency get _currency => widget.plans.currency;

  @override
  void initState() {
    super.initState();
    _close = widget.initial;
    if (_close == null) _load();
  }

  Future<void> _load() async {
    setState(() => _failed = false);
    try {
      final close = await widget.month.close(widget.fromMonth);
      if (mounted) setState(() => _close = close);
    } on ApiFailure {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _start(MonthCloseData close) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await widget.month.confirmClose(close.fromMonth);
      if (!mounted) return;
      context.pop();
      showUiToast(
        context,
        variant: UiToastVariant.info,
        title: 'Mes de ${monthName(monthDate(close.toMonth))} abierto',
        detail:
            'Empezás con ${_money(close.readyToAssignToMinor)} para asignar.',
        bottomOffset: 100,
      );
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _money(int minor) => formatMoney(minor, _currency);

  /// "+$ 380.000": the sign goes before the symbol, like the minus of
  /// `formatMoney`.
  String _signed(int minor) => '+${_money(minor)}';

  /// "Transporte reinicia en $ 0 en octubre." / "Transporte y Salidas
  /// reinician ...".
  String _restartNote(MonthCloseData close) {
    final names = close.deducted.map((line) => line.name).toList();
    final who = names.length == 1
        ? names.first
        : '${names.sublist(0, names.length - 1).join(', ')} y ${names.last}';
    final verb = names.length == 1 ? 'reinicia' : 'reinician';
    return '$who $verb en ${_money(0)} en '
        '${monthName(monthDate(close.toMonth))}.';
  }

  List<Widget> _content(MonthCloseData close) {
    final carried = [...close.carried]
      ..sort((a, b) => b.amountMinor.compareTo(a.amountMinor));
    final balanced =
        close.balanceMinor - close.availableMinor - close.futureAssignedMinor ==
        close.readyToAssignToMinor;
    final from = monthDate(close.fromMonth);
    final to = monthDate(close.toMonth);
    String capitalized(String name) =>
        '${name[0].toUpperCase()}${name.substring(1)}';
    return [
      FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          '${capitalized(monthName(from))} → ${capitalized(monthName(to))}',
          style: UiTypography.custom(40),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        'Así queda tu plan al cerrar el mes.',
        style: UiTypography.custom(16, color: UiColors.inkMuted),
      ),
      const SizedBox(height: 22),
      if (carried.isNotEmpty || close.deducted.isNotEmpty)
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Column(
            children: [
              for (final line in carried)
                UiCloseRow(
                  name: line.name,
                  outcome: '${_signed(line.amountMinor)} se arrastra',
                ),
              for (final line in close.deducted)
                UiCloseRow(
                  name: line.name,
                  outcome:
                      '${_money(-line.amountMinor)} se descuenta de Listo '
                      'para asignar',
                  deducted: true,
                ),
            ],
          ),
        ),
      if (close.deducted.isNotEmpty) ...[
        const SizedBox(height: 16),
        Text(
          _restartNote(close),
          style: UiTypography.custom(16, color: UiColors.inkMuted),
        ),
      ],
      const SizedBox(height: 22),
      UiBalanceCheck(
        title: balanced ? 'Todo cuadra' : 'No cuadra',
        equation:
            '${_money(close.balanceMinor)} − ${_money(close.availableMinor)} '
            '− ${_money(close.futureAssignedMinor)} = '
            '${_money(close.readyToAssignToMinor)}',
        caption:
            'Σ cuentas − Σ disponible − reservado a futuro = Listo para '
            'asignar',
        balanced: balanced,
      ),
      const SizedBox(height: 22),
      UiButton(
        label: 'Empezar ${monthName(to)}',
        icon: UiIcons.sparkles,
        loading: _saving,
        onPressed: widget.month.canEdit ? () => _start(close) : null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final close = _close;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
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
            const SizedBox(height: 24),
            if (close != null)
              ..._content(close)
            else if (_failed) ...[
              Text('No pudimos cargar el cierre', style: UiTypography.title),
              const SizedBox(height: 16),
              UiButton(label: 'Reintentar', onPressed: _load),
            ] else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
