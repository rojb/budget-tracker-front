// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_expense_month.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IncomeExpenseMonth extends IncomeExpenseMonth {
  @override
  final String month;
  @override
  final int incomeMinor;
  @override
  final int expenseMinor;

  factory _$IncomeExpenseMonth(
          [void Function(IncomeExpenseMonthBuilder)? updates]) =>
      (IncomeExpenseMonthBuilder()..update(updates))._build();

  _$IncomeExpenseMonth._(
      {required this.month,
      required this.incomeMinor,
      required this.expenseMinor})
      : super._();
  @override
  IncomeExpenseMonth rebuild(
          void Function(IncomeExpenseMonthBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IncomeExpenseMonthBuilder toBuilder() =>
      IncomeExpenseMonthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IncomeExpenseMonth &&
        month == other.month &&
        incomeMinor == other.incomeMinor &&
        expenseMinor == other.expenseMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, incomeMinor.hashCode);
    _$hash = $jc(_$hash, expenseMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IncomeExpenseMonth')
          ..add('month', month)
          ..add('incomeMinor', incomeMinor)
          ..add('expenseMinor', expenseMinor))
        .toString();
  }
}

class IncomeExpenseMonthBuilder
    implements Builder<IncomeExpenseMonth, IncomeExpenseMonthBuilder> {
  _$IncomeExpenseMonth? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _incomeMinor;
  int? get incomeMinor => _$this._incomeMinor;
  set incomeMinor(int? incomeMinor) => _$this._incomeMinor = incomeMinor;

  int? _expenseMinor;
  int? get expenseMinor => _$this._expenseMinor;
  set expenseMinor(int? expenseMinor) => _$this._expenseMinor = expenseMinor;

  IncomeExpenseMonthBuilder() {
    IncomeExpenseMonth._defaults(this);
  }

  IncomeExpenseMonthBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _incomeMinor = $v.incomeMinor;
      _expenseMinor = $v.expenseMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IncomeExpenseMonth other) {
    _$v = other as _$IncomeExpenseMonth;
  }

  @override
  void update(void Function(IncomeExpenseMonthBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IncomeExpenseMonth build() => _build();

  _$IncomeExpenseMonth _build() {
    final _$result = _$v ??
        _$IncomeExpenseMonth._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'IncomeExpenseMonth', 'month'),
          incomeMinor: BuiltValueNullFieldError.checkNotNull(
              incomeMinor, r'IncomeExpenseMonth', 'incomeMinor'),
          expenseMinor: BuiltValueNullFieldError.checkNotNull(
              expenseMinor, r'IncomeExpenseMonth', 'expenseMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
