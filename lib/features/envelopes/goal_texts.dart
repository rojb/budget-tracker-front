import 'package:ui/ui.dart';

import '../common/months.dart';
import 'envelopes_repository.dart';

/// Texts and numbers of goals, derived only from what the API returned (the
/// goal, its status and the state): the client never recomputes a requirement
/// or a state, it words them.

/// Month name of a goal's due date ("diciembre").
String dueMonthName(GoalData goal) =>
    goal.dueDate == null ? '' : monthName(goal.dueDate!);

/// "$ 600.000 · diciembre": the target and the month it is due.
String goalSubtitle(GoalData goal, Currency currency) {
  final target = formatMoney(goal.targetMinor, currency);
  final month = dueMonthName(goal);
  return month.isEmpty ? target : '$target · $month';
}

/// "3 meses restantes", "Vence este mes" or "Vencida" for a goal with a date.
String monthsRemainingText(GoalStatusData status) {
  final left = status.monthsRemaining;
  if (left == null) return '';
  if (left == 0) return 'Vence este mes';
  return '$left ${left == 1 ? 'mes restante' : 'meses restantes'}';
}

/// Share (0..1) of the stripes of an envelope row: how much of what the month
/// requires is assigned, from the API's `requiredMinor`.
double goalCoverage(EnvelopeLineData line) {
  final status = line.goalStatus;
  if (status == null) return 0;
  if (status.requiredMinor <= 0) return 1;
  return (line.assignedMinor / status.requiredMinor).clamp(0, 1).toDouble();
}

/// Share (0..1) of the stripes of an `EnvelopeRow` (02, 24): with a goal, how
/// much of the month's requirement is assigned; without one, the share spent.
double rowProgress(EnvelopeLineData line) {
  if (line.goalStatus != null) return goalCoverage(line);
  final spent = line.spentMinor < 0 ? 0 : line.spentMinor;
  return line.assignedMinor > 0 ? spent / line.assignedMinor : 0.0;
}

/// The goal row of 22 for [line]: "Objetivo mensual" or "Meta ... · mes", its
/// value and the stripe bar, plus "Falta ... este mes" when underfunded.
UiGoalRow goalRow(EnvelopeLineData line, Currency currency) {
  final goal = line.envelope.goal;
  final status = line.goalStatus;
  final overspent = line.state == LineState.overspent;
  if (goal == null || status == null) {
    return UiGoalRow(
      label: 'Objetivo',
      value: overspent ? 'Sobregirado' : 'Sin objetivo',
      overspent: overspent,
    );
  }
  final monthly = goal.kind == GoalKind.monthly;
  final label = monthly
      ? 'Objetivo mensual'
      : 'Meta ${formatMoney(goal.targetMinor, currency)} · ${dueMonthName(goal)}';
  final value = overspent
      ? 'Sobregirado'
      : monthly
      ? '${formatMoney(goal.targetMinor, currency)} · ${status.percent}% asignado'
      : '${status.percent}% ahorrado';
  final note = line.state == LineState.underfunded
      ? 'Falta ${formatMoney(status.missingMinor, currency)} este mes'
      : null;
  return UiGoalRow(
    label: label,
    value: value,
    progress: status.percent / 100,
    overspent: overspent,
    note: note,
  );
}

/// Variant of the `EnvelopeRow` for [line], from the API's state (Empty stays
/// the cosmetic "no goal and nothing assigned").
UiEnvelopeRowVariant rowVariant(EnvelopeLineData line) {
  switch (line.state) {
    case LineState.overspent:
      return UiEnvelopeRowVariant.overspent;
    case LineState.underfunded:
      return UiEnvelopeRowVariant.underfunded;
    case LineState.funded:
      final empty =
          line.envelope.goal == null &&
          line.assignedMinor == 0 &&
          line.availableMinor == 0;
      return empty ? UiEnvelopeRowVariant.empty : UiEnvelopeRowVariant.funded;
  }
}

/// Caption under the amount of an `EnvelopeRow`: "Falta $ X" when underfunded,
/// "Cubierto" for a funded envelope with a goal, otherwise the row's default.
String? rowCaption(EnvelopeLineData line, Currency currency) {
  final status = line.goalStatus;
  switch (line.state) {
    case LineState.underfunded:
      return status == null
          ? null
          : 'Falta ${formatMoney(status.missingMinor, currency)}';
    case LineState.funded:
      return status == null ? null : 'Cubierto';
    case LineState.overspent:
      return null;
  }
}
