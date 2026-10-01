const _names = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre',
];

/// "Septiembre 2026".
String monthLabel(DateTime month) => '${_names[month.month - 1]} ${month.year}';

/// "sep" (as in "Entró en sep").
String monthShort(DateTime month) =>
    _names[month.month - 1].substring(0, 3).toLowerCase();

/// "12 ago".
String dayMonthShort(DateTime date) => '${date.day} ${monthShort(date)}';

/// "septiembre" (lowercase, for use inside a sentence).
String monthName(DateTime month) => _names[month.month - 1].toLowerCase();

/// Month names of API month keys ("2026-08") for a sentence: "agosto",
/// "agosto y septiembre", "julio, agosto y septiembre", and "mayo a
/// septiembre" from four months on.
String monthsText(List<String> keys) {
  final names = [
    for (final key in keys)
      monthName(
        DateTime(int.parse(key.substring(0, 4)), int.parse(key.substring(5, 7))),
      ),
  ];
  return switch (names.length) {
    0 => '',
    1 => names[0],
    2 => '${names[0]} y ${names[1]}',
    3 => '${names[0]}, ${names[1]} y ${names[2]}',
    _ => '${names.first} a ${names.last}',
  };
}

/// Keys ("2026-08") from the month of [instant] to the current month, or only
/// the month of [instant] when it is not in the past: the months a change to
/// that movement recalculates (the client's preview of the API's
/// `affectedMonths`).
List<String> monthsFrom(DateTime instant, {DateTime? now}) {
  final local = instant.toLocal();
  final today = now ?? DateTime.now();
  final first = local.year * 12 + local.month - 1;
  final current = today.year * 12 + today.month - 1;
  final last = current > first ? current : first;
  return [
    for (var i = first; i <= last; i++)
      '${i ~/ 12}-${((i % 12) + 1).toString().padLeft(2, '0')}',
  ];
}

/// True when [instant] belongs to a month before the current one.
bool isClosedMonth(DateTime instant, {DateTime? now}) {
  final local = instant.toLocal();
  final today = now ?? DateTime.now();
  return local.year * 12 + local.month < today.year * 12 + today.month;
}
