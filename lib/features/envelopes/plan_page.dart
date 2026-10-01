import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../common/months.dart';
import '../plans/plans_controller.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'goal_texts.dart';

/// Screen 02 Plan del mes: the Plan tab once the plan has envelopes. This change
/// owns the structure (group headers with their "+", the envelope rows, the
/// "Sin grupo" tail, search in place and the `layers` button to 32); the monthly
/// flow (month navigation, status filters, the "+" of the joined card, 03/04/53,
/// month close) belongs to `add-monthly-assignment`. A row opens 22; its state
/// (Funded, Underfunded, Overspent) is the API's `state` (`add-envelope-goals`).
class PlanPage extends StatefulWidget {
  const PlanPage({required this.plans, required this.envelopes, super.key});

  final PlansController plans;
  final EnvelopesController envelopes;

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final TextEditingController _search = TextEditingController();
  bool _searching = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _toggleSearch() => setState(() {
    _searching = !_searching;
    if (!_searching) _search.clear();
  });

  DateTime get _month {
    final parts = (widget.envelopes.month ?? '').split('-');
    if (parts.length == 2) {
      return DateTime(int.parse(parts[0]), int.parse(parts[1]));
    }
    return DateTime(DateTime.now().year, DateTime.now().month);
  }

  Widget _row(BuildContext context, EnvelopeLineData line, Currency currency) {
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

  @override
  Widget build(BuildContext context) {
    final plans = widget.plans;
    final envelopes = widget.envelopes;
    return ListenableBuilder(
      listenable: Listenable.merge([plans, envelopes, _search]),
      builder: (context, _) {
        final currency = plans.currency;
        final query = _search.text.trim().toLowerCase();
        bool matches(EnvelopeLineData l) =>
            l.envelope.name.toLowerCase().contains(query);
        final sections = <Widget>[];
        for (final group in envelopes.groups) {
          final lines = envelopes.linesOf(group.id).where(matches).toList();
          if (query.isNotEmpty && lines.isEmpty) continue;
          sections
            ..add(
              UiGroupHeader(
                name: group.name,
                subtitle:
                    '${formatMoney(envelopes.subtotalOf(group.id), currency)} '
                    'disponible',
                onAdd: () => context.push(AppRoutes.newEnvelopeIn(group.id)),
              ),
            )
            ..addAll(lines.map((l) => _row(context, l, currency)));
        }
        final ungrouped = envelopes.linesOf(null).where(matches).toList();
        if (ungrouped.isNotEmpty) {
          sections
            ..add(
              UiGroupHeader(
                name: 'Sin grupo',
                subtitle:
                    '${formatMoney(envelopes.subtotalOf(null), currency)} '
                    'disponible',
              ),
            )
            ..addAll(ungrouped.map((l) => _row(context, l, currency)));
        }
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
              // Month navigation arrives with add-monthly-assignment.
              UiMonthSwitch(
                label: monthLabel(_month),
                onPrevious: null,
                onNext: null,
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
                // The assignment flow (03) belongs to add-monthly-assignment.
                addEnabled: false,
                onAdd: () {},
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
              if (query.isNotEmpty && sections.isEmpty)
                UiCard(
                  padding: const EdgeInsets.all(22),
                  child: Text(
                    'Ningún sobre coincide con "${_search.text.trim()}".',
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
