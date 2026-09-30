import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../atoms/icon_button.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Month calendar of 38 Fecha y hora: ‹ label ›, weekday initials starting on
/// Monday, and the days of [month]; [selected] is lavender and today is bold.
/// Labels come from the app (the package holds no locale data).
class UiCalendarMonth extends StatelessWidget {
  const UiCalendarMonth({
    required this.month,
    required this.monthLabel,
    required this.selected,
    required this.today,
    required this.onDaySelected,
    required this.onPrevious,
    required this.onNext,
    this.weekdayInitials = const ['L', 'M', 'M', 'J', 'V', 'S', 'D'],
    super.key,
  });

  /// Any day of the month to show.
  final DateTime month;
  final String monthLabel;
  final DateTime? selected;
  final DateTime today;
  final ValueChanged<DateTime> onDaySelected;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final List<String> weekdayInitials;

  static bool _sameDay(DateTime? a, DateTime b) =>
      a != null && a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month);
    final days = DateTime(month.year, month.month + 1, 0).day;
    final leading = first.weekday - 1; // Monday first.
    final cells = <Widget>[
      for (var i = 0; i < leading; i++) const SizedBox(),
      for (var d = 1; d <= days; d++)
        _day(DateTime(month.year, month.month, d)),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            UiIconButton(
              icon: UiIcons.chevronLeft,
              size: 48,
              semanticLabel: 'Mes anterior',
              onPressed: onPrevious,
            ),
            Expanded(
              child: Center(
                child: Semantics(
                  liveRegion: true,
                  child: Text(monthLabel, style: UiTypography.custom(18)),
                ),
              ),
            ),
            UiIconButton(
              icon: UiIcons.chevronRight,
              size: 48,
              semanticLabel: 'Mes siguiente',
              onPressed: onNext,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ExcludeSemantics(
          child: Row(
            children: [
              for (final initial in weekdayInitials)
                Expanded(
                  child: Center(
                    child: Text(
                      initial,
                      style: UiTypography.custom(13, color: UiColors.inkMuted),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.15,
          children: cells,
        ),
      ],
    );
  }

  Widget _day(DateTime day) {
    final isSelected = _sameDay(selected, day);
    final isToday = _sameDay(today, day);
    return UiHitTarget(
      onTap: () => onDaySelected(day),
      semanticLabel: '${day.day}',
      selected: isSelected,
      minWidth: 0,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? UiColors.lavender : null,
          shape: BoxShape.circle,
        ),
        child: ExcludeSemantics(
          child: Text(
            '${day.day}',
            style: UiTypography.custom(16, weight: isToday ? 600 : 400),
          ),
        ),
      ),
    );
  }
}
