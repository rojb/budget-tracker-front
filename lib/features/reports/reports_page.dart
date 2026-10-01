import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../common/months.dart';
import '../plan/month_keys.dart';
import '../plans/plans_controller.dart';
import 'range_sheet.dart';
import 'reports_controller.dart';
import 'reports_repository.dart';

/// Screen 17 Reportes (FR-26), opened from the bar-chart button of 01: the
/// tabs Gastos / Ingresos / Patrimonio, the selected month's figure, one bar
/// per month of the range (tap to select a month) and a card that explains
/// the month. The calendar button changes the range in place.
class ReportsPage extends StatefulWidget {
  const ReportsPage({
    required this.plans,
    required this.controllerFactory,
    super.key,
  });

  final PlansController plans;
  final ReportsController Function() controllerFactory;

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late final ReportsController _controller = widget.controllerFactory();

  Currency get _currency => widget.plans.currency;

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _money(int minor) => formatMoney(minor, _currency);

  /// "$ 265k" / "$ 1,2M": the value over the selected bar.
  String _short(int minor) {
    final major = minor / math.pow(10, _currency.minorUnits);
    final sign = major < 0 ? '−' : '';
    final abs = major.abs();
    final value = abs >= 1000000
        ? '${(abs / 1000000).toStringAsFixed(1).replaceAll('.', ',').replaceAll(',0', '')}M'
        : abs >= 1000
        ? '${(abs / 1000).round()}k'
        : abs.round().toString();
    return '$sign${_currency.symbol} $value';
  }

  int _valueOf(ReportMonthData month) => switch (_controller.tab) {
    ReportTab.spending => month.spentMinor,
    ReportTab.income => month.incomeMinor,
    ReportTab.netWorth => month.netWorthMinor,
  };

  String _figureLabel(ReportMonthData month) {
    final name = monthName(monthDate(month.month));
    return switch (_controller.tab) {
      ReportTab.spending => 'Gastado en $name',
      ReportTab.income => 'Ingresó en $name',
      ReportTab.netWorth => 'Patrimonio a fin de $name',
    };
  }

  Future<void> _pickRange() async {
    final months = await showReportRangeSheet(
      context,
      current: _controller.rangeMonths,
    );
    if (months != null) await _controller.setRange(months);
  }

  Widget _spendingCard(ReportMonthData month) {
    if (month.envelopes.isEmpty) {
      return UiInfoNote(
        text: 'No hubo gastos en ${monthName(monthDate(month.month))}.',
      );
    }
    return UiCard(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
      child: Column(
        children: [
          for (final (i, envelope) in month.envelopes.indexed) ...[
            if (i > 0) const SizedBox(height: 18),
            UiGoalRow(
              label: envelope.name,
              value:
                  '${_money(envelope.amountMinor)} · '
                  '${envelope.amountMinor * 100 ~/ month.spentMinor}%',
              progress: envelope.amountMinor / month.spentMinor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _incomeCard(ReportMonthData month) {
    final income = month.incomeMinor;
    final expense = month.expenseMinor;
    final top = math.max(income, expense);
    final name = monthName(monthDate(month.month));
    final difference = income - expense;
    final note = top == 0
        ? 'No hubo movimientos en $name.'
        : difference >= 0
        ? 'Te sobraron ${_money(difference)}.'
        : 'Gastaste ${_money(-difference)} más de lo que ingresó.';
    return UiCard(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UiGoalRow(
            label: 'Ingresos',
            value: _money(income),
            progress: top == 0 ? 0 : income / top,
          ),
          const SizedBox(height: 18),
          UiGoalRow(
            label: 'Gastos',
            value: _money(expense),
            progress: top == 0 ? 0 : expense / top,
          ),
          const SizedBox(height: 16),
          Text(note, style: UiTypography.custom(15, color: UiColors.inkMuted)),
        ],
      ),
    );
  }

  Widget _netWorthCard(ReportMonthData month) {
    final previous = _controller.previous;
    if (previous == null) {
      return UiInfoNote(
        text:
            'Suma de tus cuentas activas al cierre de '
            '${monthName(monthDate(month.month))}.',
      );
    }
    final change = month.netWorthMinor - previous.netWorthMinor;
    final before = monthName(monthDate(previous.month));
    return UiInfoNote(
      text: change == 0
          ? 'Igual que a fin de $before.'
          : change > 0
          ? 'Subió ${_money(change)} respecto de $before.'
          : 'Bajó ${_money(-change)} respecto de $before.',
    );
  }

  List<Widget> _content() {
    final controller = _controller;
    final month = controller.selected;
    if (month == null) return const [];
    final tab = controller.tab;
    return [
      Text(
        _money(_valueOf(month)),
        style: UiTypography.custom(52, weight: 300),
      ),
      Text(
        _figureLabel(month),
        style: UiTypography.custom(16, color: UiColors.inkMuted),
      ),
      const SizedBox(height: 18),
      UiBarChart(
        entries: [
          for (final entry in controller.months)
            UiBarChartEntry(
              label: _shortMonth(entry.month),
              value: _valueOf(entry),
              semanticLabel:
                  '${monthLabel(monthDate(entry.month))}, '
                  '${_money(_valueOf(entry))}',
            ),
        ],
        selectedIndex: controller.selectedIndex,
        selectedValue: _short(_valueOf(month)),
        onSelected: controller.select,
      ),
      const SizedBox(height: 26),
      Text(switch (tab) {
        ReportTab.spending => 'Dónde se fue',
        ReportTab.income => 'Ingresos y gastos',
        ReportTab.netWorth => 'Cambio en el mes',
      }, style: UiTypography.custom(22)),
      const SizedBox(height: 12),
      switch (tab) {
        ReportTab.spending => _spendingCard(month),
        ReportTab.income => _incomeCard(month),
        ReportTab.netWorth => _netWorthCard(month),
      },
    ];
  }

  String _shortMonth(String key) {
    final short = monthShort(monthDate(key));
    return '${short[0].toUpperCase()}${short.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    // A child of the 01 branch: the shell gives the Scaffold, the safe area and
    // the NavCluster with Inicio selected.
    return ListenableBuilder(
      listenable: Listenable.merge([_controller, widget.plans]),
      builder: (context, _) {
        final controller = _controller;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              children: [
                Text('Reportes', style: UiTypography.custom(44)),
                const Spacer(),
                UiIconButton(
                  icon: UiIcons.calendar,
                  semanticLabel: 'Elegir rango',
                  onPressed: _pickRange,
                ),
              ],
            ),
            const SizedBox(height: 16),
            UiToggle(
              labels: const ['Gastos', 'Ingresos', 'Patrimonio'],
              selectedIndex: controller.tab.index,
              onChanged: (index) => controller.setTab(ReportTab.values[index]),
            ),
            const SizedBox(height: 22),
            if (controller.failed) ...[
              Text('No pudimos cargar los reportes', style: UiTypography.title),
              const SizedBox(height: 16),
              UiButton(label: 'Reintentar', onPressed: controller.load),
            ] else if (controller.selected == null)
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ..._content(),
          ],
        );
      },
    );
  }
}
