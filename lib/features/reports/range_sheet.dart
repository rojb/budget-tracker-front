import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// The ranges of 17, all ending in the current month.
const reportRanges = [3, 6, 12];

/// Range picker of 17 (the calendar button): "Últimos 3 / 6 / 12 meses", the
/// current one marked. Returns the chosen number of months, null when closed.
Future<int?> showReportRangeSheet(
  BuildContext context, {
  required int current,
}) {
  return showUiSheet<int>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Rango',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final months in reportRanges) ...[
            UiChoiceCard(
              icon: UiIcons.calendar,
              title: 'Últimos $months meses',
              description: 'Hasta este mes',
              selected: months == current,
              onTap: () => Navigator.of(sheetContext).pop(months),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    ),
  );
}
