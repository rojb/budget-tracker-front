// Budget month keys of the API ("2026-09"). They compare correctly as strings.

/// First day of the month of [key].
DateTime monthDate(String key) =>
    DateTime(int.parse(key.substring(0, 4)), int.parse(key.substring(5, 7)));

/// The key of [date]'s month.
String monthKeyOf(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}';

/// The key [delta] months after [key] (before it when negative).
String shiftMonth(String key, int delta) {
  final date = monthDate(key);
  return monthKeyOf(DateTime(date.year, date.month + delta));
}
