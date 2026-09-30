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
