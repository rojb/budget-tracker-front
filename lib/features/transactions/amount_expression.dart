/// Arithmetic expression typed in the amount field of 07 / 09 (FR-18).
///
/// Pure Dart and exact: operands are decimal strings turned into rationals with
/// `BigInt`, `×` and `÷` bind tighter than `+` and `−`, and the result is
/// rounded half up to the currency's minor units only when it is read with
/// [minor]. No floating point is involved anywhere.
class AmountExpression {
  AmountExpression();

  static const String plus = '+';
  static const String minus = '−';
  static const String times = '×';
  static const String divide = '÷';
  static const Set<String> operators = {plus, minus, times, divide};

  /// Largest result accepted, in minor units (15 digits).
  static final BigInt _maxMinor = BigInt.parse('999999999999999');
  static const int _maxIntegerDigits = 12;
  static const int _maxDecimals = 4;

  // Operands ("12300", "12,5") and operators, alternating, operand first.
  final List<String> _tokens = [];

  bool get isEmpty => _tokens.isEmpty;

  /// True once an operator was typed: the capsule then shows the result and
  /// the caption the expression.
  bool get hasOperator => _tokens.any(operators.contains);

  bool get _endsWithOperator =>
      _tokens.isNotEmpty && operators.contains(_tokens.last);

  void clear() => _tokens.clear();

  /// A digit key; digit strings of any length are accepted ("00").
  void digit(String digits) {
    for (final d in digits.split('')) {
      _digit(d);
    }
  }

  void _digit(String d) {
    if (d.codeUnitAt(0) < 0x30 || d.codeUnitAt(0) > 0x39) return;
    if (_tokens.isEmpty || _endsWithOperator) {
      _tokens.add(d);
      return;
    }
    final operand = _tokens.last;
    final comma = operand.indexOf(',');
    if (comma >= 0) {
      if (operand.length - comma - 1 < _maxDecimals) _tokens.last = operand + d;
      return;
    }
    if (operand == '0') {
      _tokens.last = d;
    } else if (operand.length < _maxIntegerDigits) {
      _tokens.last = operand + d;
    }
  }

  /// The decimal comma; one per operand.
  void decimal() {
    if (_tokens.isEmpty || _endsWithOperator) {
      _tokens.add('0,');
    } else if (!_tokens.last.contains(',')) {
      _tokens.last = '${_tokens.last},';
    }
  }

  /// An operator key. Ignored on an empty expression (a result must be
  /// positive, so there is no leading minus); replaces a trailing operator.
  void operator(String op) {
    if (!operators.contains(op) || _tokens.isEmpty) return;
    if (_endsWithOperator) {
      _tokens.last = op;
      return;
    }
    if (_tokens.last.endsWith(',')) {
      _tokens.last = _tokens.last.substring(0, _tokens.last.length - 1);
    }
    _tokens.add(op);
  }

  /// Backspace: the last character of the operand, or the trailing operator.
  void delete() {
    if (_tokens.isEmpty) return;
    final last = _tokens.last;
    if (operators.contains(last) || last.length == 1) {
      _tokens.removeLast();
    } else {
      _tokens.last = last.substring(0, last.length - 1);
    }
  }

  /// Replaces the expression with a single amount (for example the amount
  /// carried from another screen). [minor] is in minor units.
  void setMinor(int minor, int minorUnits) {
    _tokens.clear();
    if (minor <= 0) return;
    final factor = _pow10(minorUnits);
    final whole = minor ~/ factor;
    final fraction = minor % factor;
    _tokens.add(
      minorUnits > 0 && fraction != 0
          ? '$whole,${fraction.toString().padLeft(minorUnits, '0')}'
          : '$whole',
    );
  }

  /// True when the expression cannot be computed (division by zero, result
  /// out of range). An empty expression is not invalid, it has no value.
  bool isInvalid(int minorUnits) => !isEmpty && _value(minorUnits) == null;

  /// The result in minor units, rounded half up; null when empty or invalid.
  /// It can be zero or negative (`5 − 10`): the caller decides if it is savable.
  int? minor(int minorUnits) => _value(minorUnits)?.toInt();

  BigInt? _value(int minorUnits) {
    final tokens = [..._tokens];
    if (tokens.isNotEmpty && operators.contains(tokens.last)) {
      tokens.removeLast();
    }
    if (tokens.isEmpty) return null;
    // First pass: × and ÷ left to right, leaving a list of terms and + / −.
    final terms = <_Rational>[_parse(tokens.first)];
    final signs = <String>[];
    for (var i = 1; i < tokens.length; i += 2) {
      final op = tokens[i];
      final right = _parse(tokens[i + 1]);
      if (op == times) {
        terms.last = terms.last.times(right);
      } else if (op == divide) {
        if (right.numerator == BigInt.zero) return null;
        terms.last = terms.last.dividedBy(right);
      } else {
        signs.add(op);
        terms.add(right);
      }
    }
    var sum = terms.first;
    for (var i = 0; i < signs.length; i++) {
      sum = signs[i] == plus ? sum.plus(terms[i + 1]) : sum.minus(terms[i + 1]);
    }
    final scaled = sum.times(
      _Rational(BigInt.from(_pow10(minorUnits)), BigInt.one),
    );
    final rounded = scaled.roundHalfUp();
    if (rounded.abs() > _maxMinor) return null;
    return rounded;
  }

  /// Value of the amount capsule: the result when there is an operation (0
  /// while it cannot be computed), the operand being typed otherwise.
  String display(int minorUnits) {
    if (isEmpty) return '0';
    if (!hasOperator) return _group(_tokens.first);
    final value = minor(minorUnits);
    return value == null ? '0' : formatMinor(value, minorUnits);
  }

  /// The expression under the capsule ("12.300 + 6.150"); null without an
  /// operation, where the capsule already shows the typed amount.
  String? get caption {
    if (!hasOperator) return null;
    return _tokens
        .map((token) => operators.contains(token) ? token : _group(token))
        .join(' ');
  }

  /// "12.300" / "1.250,50": [minor] without the currency symbol.
  static String formatMinor(int minor, int minorUnits) {
    final negative = minor < 0;
    final abs = minor.abs();
    final factor = _pow10(minorUnits);
    final buffer = StringBuffer(negative ? '−' : '')
      ..write(_groupDigits((abs ~/ factor).toString()));
    if (minorUnits > 0) {
      buffer
        ..write(',')
        ..write((abs % factor).toString().padLeft(minorUnits, '0'));
    }
    return buffer.toString();
  }

  // "12300" -> "12.300"; "1234,5" -> "1.234,5"; "12," stays "12,".
  static String _group(String operand) {
    final comma = operand.indexOf(',');
    if (comma < 0) return _groupDigits(operand);
    return '${_groupDigits(operand.substring(0, comma))}${operand.substring(comma)}';
  }

  static String _groupDigits(String digits) {
    final out = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) out.write('.');
      out.write(digits[i]);
    }
    return out.toString();
  }

  static int _pow10(int exponent) {
    var result = 1;
    for (var i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }

  // "12,5" -> 125/10.
  static _Rational _parse(String operand) {
    final comma = operand.indexOf(',');
    if (comma < 0) return _Rational(BigInt.parse(operand), BigInt.one);
    final fraction = operand.substring(comma + 1);
    return _Rational(
      BigInt.parse('${operand.substring(0, comma)}$fraction'),
      BigInt.from(10).pow(fraction.length),
    );
  }
}

class _Rational {
  _Rational(this.numerator, this.denominator);

  final BigInt numerator;
  final BigInt denominator; // always > 0

  _Rational plus(_Rational o) => _Rational(
    numerator * o.denominator + o.numerator * denominator,
    denominator * o.denominator,
  );

  _Rational minus(_Rational o) => _Rational(
    numerator * o.denominator - o.numerator * denominator,
    denominator * o.denominator,
  );

  _Rational times(_Rational o) =>
      _Rational(numerator * o.numerator, denominator * o.denominator);

  _Rational dividedBy(_Rational o) {
    final n = numerator * o.denominator;
    final d = denominator * o.numerator;
    return d.isNegative ? _Rational(-n, -d) : _Rational(n, d);
  }

  /// Nearest integer, halves away from zero.
  BigInt roundHalfUp() {
    final twice = numerator.abs() * BigInt.two + denominator;
    final magnitude = twice ~/ (denominator * BigInt.two);
    return numerator.isNegative ? -magnitude : magnitude;
  }
}
