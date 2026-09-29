import 'package:intl/intl.dart';

/// Plan currencies (mirror of the API `Currency` object: code, symbol,
/// minorUnits). Kept here so `packages/ui` never imports the API client.
enum Currency {
  ars(code: 'ARS', symbol: r'$', minorUnits: 0),
  usd(code: 'USD', symbol: r'US$', minorUnits: 2),
  eur(code: 'EUR', symbol: '€', minorUnits: 2);

  const Currency({
    required this.code,
    required this.symbol,
    required this.minorUnits,
  });

  final String code;
  final String symbol;
  final int minorUnits;
}

final NumberFormat _grouping = NumberFormat.decimalPattern('es_AR');

/// Formats an integer amount in minor units for display (es-AR).
///
/// `.` groups thousands, `,` separates decimals, decimals follow the
/// currency's minor units, and a negative amount gets a `−` (U+2212) before
/// the symbol: `$ 48.200`, `US$ 1.250,50`, `€ 980,00`, `−US$ 12,50`.
/// Integer arithmetic only: the amount never goes through a double.
String formatMoney(int minor, Currency currency) {
  final negative = minor < 0;
  final abs = minor.abs();
  final factor = _pow10(currency.minorUnits);
  final whole = abs ~/ factor;
  final fraction = abs % factor;

  final buffer = StringBuffer();
  if (negative) buffer.write('−');
  buffer
    ..write(currency.symbol)
    ..write(' ')
    ..write(_grouping.format(whole));
  if (currency.minorUnits > 0) {
    buffer
      ..write(',')
      ..write(fraction.toString().padLeft(currency.minorUnits, '0'));
  }
  return buffer.toString();
}

int _pow10(int exponent) {
  var result = 1;
  for (var i = 0; i < exponent; i++) {
    result *= 10;
  }
  return result;
}
