import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import 'dates.dart';

/// Movements grouped by the local day they were registered, last registered first, each group under its header
/// ("Hoy · martes 29", "Ayer · lunes 28", then "Sábado 26", PRD-ux-spec.md
/// 6.1 rule 5) with each row in its own white card. [items] must already be
/// ordered newest first. Shared by 10 Movimientos and 14 Detalle de cuenta.
List<Widget> buildDayGroups<T>(
  List<T> items, {
  required DateTime Function(T item) registeredAt,
  required Widget Function(T item) rowBuilder,
  DateTime? now,
}) {
  final widgets = <Widget>[];
  String? group;
  for (final item in items) {
    final label = dayGroupLabel(registeredAt(item), now: now);
    if (label != group) {
      group = label;
      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Text(label, style: UiTypography.custom(19)),
        ),
      );
    }
    // Each movement is its own white card, as the renders of 10 and 14 draw it.
    widgets
      ..add(
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: rowBuilder(item),
        ),
      )
      ..add(const SizedBox(height: 8));
  }
  return widgets;
}
