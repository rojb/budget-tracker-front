import 'months.dart';

const _weekdays = [
  'lunes',
  'martes',
  'miércoles',
  'jueves',
  'viernes',
  'sábado',
  'domingo',
];

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String _hhmm(DateTime t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// "Hoy, 14:32", "Ayer, 09:00" or "12 sep, 09:00" (local time).
String dateTimeLabel(DateTime instant, {DateTime? now}) {
  final local = instant.toLocal();
  final today = now ?? DateTime.now();
  final String day;
  if (_sameDay(local, today)) {
    day = 'Hoy';
  } else if (_sameDay(local, today.subtract(const Duration(days: 1)))) {
    day = 'Ayer';
  } else {
    day = dayMonthShort(local);
  }
  return '$day, ${_hhmm(local)}';
}

/// "14:32" (local time).
String timeLabel(DateTime instant) => _hhmm(instant.toLocal());

/// Day group header of PRD-ux-spec.md 6.1 rule 5: "Hoy · martes 29",
/// "Ayer · lunes 28", then "Sábado 26".
String dayGroupLabel(DateTime instant, {DateTime? now}) {
  final local = instant.toLocal();
  final today = now ?? DateTime.now();
  final weekday = _weekdays[local.weekday - 1];
  if (_sameDay(local, today)) return 'Hoy · $weekday ${local.day}';
  if (_sameDay(local, today.subtract(const Duration(days: 1)))) {
    return 'Ayer · $weekday ${local.day}';
  }
  return '${weekday[0].toUpperCase()}${weekday.substring(1)} ${local.day}';
}
