import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../common/date_sheets.dart';
import '../common/edit_sheets.dart';
import '../common/months.dart';
import 'envelopes_repository.dart';

/// The objective being edited in 23 and 31: no goal ([kind] null), monthly, or
/// by a date. The API validates it; this only holds what the user typed.
class GoalDraft {
  const GoalDraft({this.kind, this.targetMinor = 0, this.dueDate});

  factory GoalDraft.of(GoalData? goal) => goal == null
      ? const GoalDraft()
      : GoalDraft(
          kind: goal.kind,
          targetMinor: goal.targetMinor,
          dueDate: goal.dueDate,
        );

  final GoalKind? kind;
  final int targetMinor;
  final DateTime? dueDate;

  /// The goal to send, or null for "Sin objetivo".
  GoalData? toGoal() => kind == null
      ? null
      : GoalData(
          kind: kind!,
          targetMinor: targetMinor,
          dueDate: kind == GoalKind.targetByDate ? dueDate : null,
        );

  GoalDraft withKind(GoalKind? next, Currency currency) {
    if (next == null) return const GoalDraft();
    // A new goal starts from a sensible amount instead of 0.
    final start = targetMinor > 0 ? targetMinor : quickAmounts(currency)[1];
    return GoalDraft(
      kind: next,
      targetMinor: start,
      dueDate: next == GoalKind.targetByDate ? dueDate : null,
    );
  }

  GoalDraft withTarget(int minor) =>
      GoalDraft(kind: kind, targetMinor: minor, dueDate: dueDate);

  GoalDraft withDueDate(DateTime date) =>
      GoalDraft(kind: kind, targetMinor: targetMinor, dueDate: date);
}

/// Quick amounts of the objective, in minor units of [currency]: ARS 20.000,
/// 50.000, 100.000 and 200.000; USD, EUR and BOB 50, 100, 250 and 500.
List<int> quickAmounts(Currency currency) {
  final factor = math.pow(10, currency.minorUnits).toInt();
  final major = currency == Currency.ars
      ? const [20000, 50000, 100000, 200000]
      : const [50, 100, 250, 500];
  return [for (final value in major) value * factor];
}

/// The objective block of 31 Nuevo sobre and 23 Editar sobre: the type chips,
/// the target in the `AmountCapsule` (tap for an own amount) with quick
/// amounts, and, for "Con fecha", the "Fecha límite" row.
class GoalFields extends StatelessWidget {
  const GoalFields({
    required this.draft,
    required this.onChanged,
    required this.currency,
    this.title = 'Tipo de objetivo',
    this.error,
    super.key,
  });

  final GoalDraft draft;
  final ValueChanged<GoalDraft> onChanged;
  final Currency currency;
  final String title;

  /// Validation message for the due date ("Elegí una fecha límite.").
  final String? error;

  Future<void> _editAmount(BuildContext context) async {
    final minor = await showAmountSheet(
      context,
      title: draft.kind == GoalKind.monthly
          ? 'Objetivo mensual'
          : 'Monto a alcanzar',
      currency: currency,
      initialMinor: draft.targetMinor,
    );
    if (minor != null && minor > 0) onChanged(draft.withTarget(minor));
  }

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDateSheet(
      context,
      title: 'Fecha límite',
      initial: draft.dueDate,
    );
    if (date != null) onChanged(draft.withDueDate(date));
  }

  @override
  Widget build(BuildContext context) {
    final kind = draft.kind;
    final presets = quickAmounts(currency);
    // The current target joins the quick amounts when it is not one of them, so
    // the selected one is always visible.
    final amounts = [
      if (draft.targetMinor > 0 && !presets.contains(draft.targetMinor))
        draft.targetMinor,
      ...presets,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(title, style: UiTypography.custom(19)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            UiChip(
              label: 'Sin objetivo',
              selected: kind == null,
              onPressed: () => onChanged(draft.withKind(null, currency)),
            ),
            UiChip(
              label: 'Mensual',
              selected: kind == GoalKind.monthly,
              onPressed: () =>
                  onChanged(draft.withKind(GoalKind.monthly, currency)),
            ),
            UiChip(
              label: 'Con fecha',
              selected: kind == GoalKind.targetByDate,
              onPressed: () =>
                  onChanged(draft.withKind(GoalKind.targetByDate, currency)),
            ),
          ],
        ),
        if (kind != null) ...[
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              kind == GoalKind.monthly
                  ? 'Objetivo mensual'
                  : 'Monto a alcanzar',
              style: UiTypography.custom(17, color: UiColors.inkMuted),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Semantics(
              button: true,
              label: 'Cambiar el monto del objetivo',
              child: GestureDetector(
                onTap: () => _editAmount(context),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: UiAmountCapsule(
                    symbol: currency.symbol,
                    value: formatAmountValue(draft.targetMinor, currency),
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
              for (final minor in amounts.take(5))
                UiChip(
                  label: formatAmountValue(minor, currency),
                  selected: minor == draft.targetMinor,
                  onPressed: () => onChanged(draft.withTarget(minor)),
                ),
            ],
          ),
        ],
        if (kind == GoalKind.targetByDate) ...[
          const SizedBox(height: 16),
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: UiFieldRow(
              label: 'Fecha límite',
              value: draft.dueDate == null
                  ? '—'
                  : '${dayMonthShort(draft.dueDate!)} ${draft.dueDate!.year}',
              onTap: () => _pickDate(context),
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: 8),
            UiFormMessage(message: error!),
          ],
        ],
      ],
    );
  }
}
