import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../common/months.dart';
import '../plan/future_month_notice.dart';
import '../plan/month_controller.dart';
import '../plan/month_keys.dart';
import '../plan/plan_filters.dart';
import '../plans/plans_controller.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'goal_texts.dart';

/// Screen 02 Plan del mes, and 04 Plan · mes futuro when the viewed month is
/// after the current one: the Plan tab once the plan has envelopes. The
/// structure (group headers with their "+", the envelope rows, the "Sin grupo"
/// tail, search in place and the `layers` button to 32) comes from
/// `add-envelopes`; the monthly flow (month navigation, status filters, the
/// future month view and the "+" of the joined card) from
/// `add-monthly-assignment`, through [MonthController], which also opens 25
/// Cierre de mes by itself when the previous month's close is pending. A row
/// opens 22; its state (Funded, Underfunded, Overspent) is the API's `state`.
class PlanPage extends StatefulWidget {
  const PlanPage({
    required this.plans,
    required this.envelopes,
    required this.month,
    super.key,
  });

  final PlansController plans;
  final EnvelopesController envelopes;
  final MonthController month;

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final TextEditingController _search = TextEditingController();
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    widget.month.addListener(_checkClose);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkClose());
  }

  @override
  void dispose() {
    widget.month.removeListener(_checkClose);
    _search.dispose();
    super.dispose();
  }

  /// Opens 25 by itself when the previous month's close is pending.
  Future<void> _checkClose() async {
    final close = await widget.month.pendingClose();
    if (close == null || !mounted) return;
    context.push(AppRoutes.monthClose(close.fromMonth), extra: close);
  }

  void _toggleSearch() => setState(() {
    _searching = !_searching;
    if (!_searching) _search.clear();
  });

  DateTime get _month {
    final month = widget.envelopes.month;
    if (month != null) return monthDate(month);
    return DateTime(DateTime.now().year, DateTime.now().month);
  }

  Widget _row(
    BuildContext context,
    EnvelopeLineData line,
    Currency currency, {
    required bool future,
  }) {
    if (future) return _futureRow(context, line, currency);
    // Spending comes from the engine (transactions), not from assigned − available, which
    // carryover and income sent to an envelope would falsify.
    final spent = math.max(0, line.spentMinor);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: UiEnvelopeRow(
        variant: rowVariant(line),
        icon: uiEnvelopeIcon(line.envelope.icon),
        name: line.envelope.name,
        subtitle:
            '${formatMoney(spent, currency)} de '
            '${formatMoney(line.assignedMinor, currency)}',
        amount: formatMoney(line.availableMinor, currency),
        caption: rowCaption(line, currency),
        // With a goal the stripes show how much of the month's requirement is
        // assigned (PRD-ux-spec.md 5, state "Sobre"); without one, the share spent.
        progress: rowProgress(line),
        onTap: () => context.push(AppRoutes.envelopeDetail(line.envelope.id)),
      ),
    );
  }

  /// A row of 04: what is already reserved for that month. There is no
  /// carryover or spending in a month that has not started.
  Widget _futureRow(
    BuildContext context,
    EnvelopeLineData line,
    Currency currency,
  ) {
    final reserved = line.assignedMinor != 0;
    final current = widget.month.currentMonth;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: UiEnvelopeRow(
        variant: reserved
            ? UiEnvelopeRowVariant.funded
            : UiEnvelopeRowVariant.empty,
        icon: uiEnvelopeIcon(line.envelope.icon),
        name: line.envelope.name,
        subtitle: reserved && current != null
            ? 'Reservado desde ${monthName(monthDate(current))}'
            : 'Sin asignar todavía',
        amount: formatMoney(line.assignedMinor, currency),
        caption: reserved ? 'Asignado' : 'Sin asignar',
        progress: !reserved
            ? 0
            : line.goalStatus != null
            ? goalCoverage(line)
            : 1,
        onTap: () => context.push(AppRoutes.envelopeDetail(line.envelope.id)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plans = widget.plans;
    final envelopes = widget.envelopes;
    final month = widget.month;
    return ListenableBuilder(
      listenable: Listenable.merge([plans, envelopes, month, _search]),
      builder: (context, _) {
        final currency = plans.currency;
        final future = month.isFuture;
        final filter = month.filter;
        final query = _search.text.trim().toLowerCase();
        bool matches(EnvelopeLineData l) =>
            l.envelope.name.toLowerCase().contains(query) &&
            matchesFilter(l, filter);
        final narrowed = query.isNotEmpty || filter != StatusFilter.all;
        String subtotal(String? groupId) => future
            ? '${formatMoney(envelopes.linesOf(groupId).fold(0, (sum, l) => sum + l.assignedMinor), currency)} '
                  'asignado'
            : '${formatMoney(envelopes.subtotalOf(groupId), currency)} '
                  'disponible';
        final sections = <Widget>[];
        for (final group in envelopes.groups) {
          final lines = envelopes.linesOf(group.id).where(matches).toList();
          if (narrowed && lines.isEmpty) continue;
          sections
            ..add(
              UiGroupHeader(
                name: group.name,
                subtitle: subtotal(group.id),
                onAdd: () => context.push(AppRoutes.newEnvelopeIn(group.id)),
              ),
            )
            ..addAll(
              lines.map((l) => _row(context, l, currency, future: future)),
            );
        }
        final ungrouped = envelopes.linesOf(null).where(matches).toList();
        if (ungrouped.isNotEmpty) {
          sections
            ..add(UiGroupHeader(name: 'Sin grupo', subtitle: subtotal(null)))
            ..addAll(
              ungrouped.map((l) => _row(context, l, currency, future: future)),
            );
        }
        final emptyText = query.isNotEmpty
            ? 'Ningún sobre coincide con "${_search.text.trim()}".'
            : emptyFilterText(filter);
        return RefreshIndicator(
          onRefresh: envelopes.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Row(
                children: [
                  Text('Plan', style: UiTypography.custom(36)),
                  if (currency != Currency.ars) ...[
                    const SizedBox(width: 10),
                    UiChip(
                      label: currency.symbol,
                      selected: true,
                      size: UiChipSize.compact,
                    ),
                  ],
                  const Spacer(),
                  UiIconButton(
                    icon: UiIcons.layers,
                    semanticLabel: 'Grupos',
                    onPressed: () => context.push(AppRoutes.groups),
                  ),
                  const SizedBox(width: 8),
                  UiIconButton(
                    icon: _searching ? UiIcons.close : UiIcons.search,
                    semanticLabel: _searching ? 'Cerrar búsqueda' : 'Buscar',
                    onPressed: _toggleSearch,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              UiMonthSwitch(
                label: monthLabel(_month),
                onPrevious: envelopes.loading ? null : month.previous,
                onNext: envelopes.loading ? null : month.next,
              ),
              const SizedBox(height: 14),
              UiJoinedCard(
                primaryValue: formatMoney(
                  envelopes.readyToAssignMinor,
                  currency,
                ),
                primaryLabel: 'Listo para asignar',
                secondaryValue: '${envelopes.envelopeCount}',
                secondaryLabel: 'Sobres activos',
                addLabel: 'Asignar dinero',
                addEnabled: month.canEdit,
                onAdd: () =>
                    context.push(AppRoutes.assign(month: envelopes.month)),
              ),
              const SizedBox(height: 14),
              if (future) ...[
                FutureMonthNotice(onToday: month.today),
                const SizedBox(height: 14),
              ],
              PlanFilterChips(
                lines: envelopes.lines,
                selected: filter,
                onSelected: month.setFilter,
              ),
              const SizedBox(height: 14),
              if (_searching) ...[
                UiTextField(
                  label: 'Buscar sobre',
                  controller: _search,
                  textInputAction: TextInputAction.search,
                ),
                const SizedBox(height: 10),
              ],
              if (narrowed && sections.isEmpty)
                UiCard(
                  padding: const EdgeInsets.all(22),
                  child: Text(
                    emptyText,
                    style: UiTypography.custom(15, color: UiColors.inkMuted),
                  ),
                )
              else
                ...sections,
            ],
          ),
        );
      },
    );
  }
}
