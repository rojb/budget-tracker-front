import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import '../envelopes/envelopes_repository.dart';
import '../envelopes/goal_texts.dart';

/// Status filters of the plan view (FR-21), over the API's state of each line.
enum StatusFilter { all, overspent, underfunded, funded }

/// True when [line] is shown under [filter]. "Cubiertos" are the funded rows
/// with money (an envelope with nothing is Empty, not covered).
bool matchesFilter(EnvelopeLineData line, StatusFilter filter) =>
    switch (filter) {
      StatusFilter.all => true,
      StatusFilter.overspent => line.state == LineState.overspent,
      StatusFilter.underfunded => line.state == LineState.underfunded,
      StatusFilter.funded => rowVariant(line) == UiEnvelopeRowVariant.funded,
    };

/// What the list says when no envelope of the month matches [filter].
String emptyFilterText(StatusFilter filter) => switch (filter) {
  StatusFilter.all => 'Este mes no tiene sobres.',
  StatusFilter.overspent => 'Ningún sobre está sobregirado este mes.',
  StatusFilter.underfunded => 'A ningún sobre le falta dinero este mes.',
  StatusFilter.funded => 'Ningún sobre está cubierto este mes.',
};

/// The chip row of 02/04: "Todos", "Sobregirados · N", "Falta · N" and
/// "Cubiertos · N", counted over [lines]; scrolls sideways on narrow screens.
class PlanFilterChips extends StatelessWidget {
  const PlanFilterChips({
    required this.lines,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<EnvelopeLineData> lines;
  final StatusFilter selected;
  final ValueChanged<StatusFilter> onSelected;

  int _count(StatusFilter filter) =>
      lines.where((line) => matchesFilter(line, filter)).length;

  @override
  Widget build(BuildContext context) {
    Widget chip(StatusFilter filter, String label, IconData? icon) => Padding(
      padding: const EdgeInsets.only(right: 8),
      child: UiChip(
        label: filter == StatusFilter.all
            ? label
            : '$label · ${_count(filter)}',
        icon: icon,
        selected: selected == filter,
        onPressed: () => onSelected(filter),
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          chip(StatusFilter.all, 'Todos', null),
          chip(StatusFilter.overspent, 'Sobregirados', UiIcons.warning),
          chip(StatusFilter.underfunded, 'Falta', UiIcons.clock),
          chip(StatusFilter.funded, 'Cubiertos', UiIcons.check),
        ],
      ),
    );
  }
}
