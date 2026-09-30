import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import 'dates.dart';

/// Movements grouped by local day, newest first, each group under its header
/// ("Hoy · martes 29", "Ayer · lunes 28", then "Sábado 26", PRD-ux-spec.md
/// 6.1 rule 5) with its rows in one white card. [items] must already be
/// ordered newest first. Shared by 10 Movimientos and 14 Detalle de cuenta.
List<Widget> buildDayGroups<T>(
  List<T> items, {
  required DateTime Function(T item) occurredAt,
  required Widget Function(T item) rowBuilder,
  DateTime? now,
}) {
  final widgets = <Widget>[];
  String? group;
  var rows = <Widget>[];
  void flush() {
    if (group == null) return;
    widgets
      ..add(
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Text(group, style: UiTypography.custom(19)),
        ),
      )
      ..add(
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(children: rows),
        ),
      )
      ..add(const SizedBox(height: 8));
  }

  for (final item in items) {
    final label = dayGroupLabel(occurredAt(item), now: now);
    if (label != group) {
      flush();
      group = label;
      rows = [];
    }
    rows.add(rowBuilder(item));
  }
  flush();
  return widgets;
}
