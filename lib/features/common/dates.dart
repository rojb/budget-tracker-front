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

/// The time in a movement row: "09:12", or "dom 27, 09:12" when the day of the
/// movement is not the day it was registered (the lists group by registration).
String movementTimeLabel(DateTime occurredAt, DateTime createdAt) {
  final local = occurredAt.toLocal();
  if (_sameDay(local, createdAt.toLocal())) return _hhmm(local);
  final weekday = _weekdays[local.weekday - 1].substring(0, 3);
  return '$weekday ${local.day}, ${_hhmm(local)}';
}

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
