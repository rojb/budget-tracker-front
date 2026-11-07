import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import '../envelopes/envelopes_repository.dart';
import '../envelopes/goal_texts.dart';

/// Status filters of the plan view (FR-21), over the API's state of each line.
enum StatusFilter { all, overspent, underfunded, funded, unassigned }

/// True when [line] is shown under [filter]. "Cubiertos" are the funded rows
/// with money; an envelope with no goal and nothing assigned is Empty and
/// belongs to "Sin asignar", so the four state chips add up to every envelope.
bool matchesFilter(EnvelopeLineData line, StatusFilter filter) =>
    switch (filter) {
      StatusFilter.all => true,
      StatusFilter.overspent => line.state == LineState.overspent,
      StatusFilter.underfunded => line.state == LineState.underfunded,
      StatusFilter.funded => rowVariant(line) == UiEnvelopeRowVariant.funded,
      StatusFilter.unassigned => rowVariant(line) == UiEnvelopeRowVariant.empty,
    };

/// What the list says when no envelope of the month matches [filter].
String emptyFilterText(StatusFilter filter) => switch (filter) {
  StatusFilter.all => 'Este mes no tiene sobres.',
  StatusFilter.overspent => 'Ningún sobre está sobregirado este mes.',
  StatusFilter.underfunded => 'A ningún sobre le falta dinero este mes.',
  StatusFilter.funded => 'Ningún sobre está cubierto este mes.',
  StatusFilter.unassigned =>
    'Todos los sobres tienen dinero o un objetivo este mes.',
};

/// The chip row of 02/04: "Todos", "Sobregirados · N", "Falta · N",
/// "Cubiertos · N" and "Sin asignar · N", counted over [lines]. It scrolls
/// sideways in a [UiChipRow] that spans the full screen width (the page pads its
/// content by 20 dp), with the same 20 dp before the first chip.
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
    Widget chip(StatusFilter filter, String label, IconData? icon) => UiChip(
      label: filter == StatusFilter.all ? label : '$label · ${_count(filter)}',
      icon: icon,
      selected: selected == filter,
      onPressed: () => onSelected(filter),
    );
    return LayoutBuilder(
      builder: (context, box) => SizedBox(
        height: UiSizes.chipHeight,
        child: OverflowBox(
          minWidth: box.maxWidth + _pageGutter * 2,
          maxWidth: box.maxWidth + _pageGutter * 2,
          child: UiChipRow(
            children: [
              // The row's spacing (8) plus this leaves the page gutter.
              const SizedBox(width: _pageGutter - 8),
              chip(StatusFilter.all, 'Todos', null),
              chip(StatusFilter.overspent, 'Sobregirados', UiIcons.warning),
              chip(StatusFilter.underfunded, 'Falta', UiIcons.clock),
              chip(StatusFilter.funded, 'Cubiertos', UiIcons.check),
              chip(StatusFilter.unassigned, 'Sin asignar', null),
            ],
          ),
        ),
      ),
    );
  }

  static const double _pageGutter = 20;
}
