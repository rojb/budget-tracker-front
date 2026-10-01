// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_expense_report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IncomeExpenseReport extends IncomeExpenseReport {
  @override
  final String from;
  @override
  final String to;
  @override
  final BuiltList<IncomeExpenseMonth> months;

  factory _$IncomeExpenseReport(
          [void Function(IncomeExpenseReportBuilder)? updates]) =>
      (IncomeExpenseReportBuilder()..update(updates))._build();

  _$IncomeExpenseReport._(
      {required this.from, required this.to, required this.months})
      : super._();
  @override
  IncomeExpenseReport rebuild(
          void Function(IncomeExpenseReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IncomeExpenseReportBuilder toBuilder() =>
      IncomeExpenseReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IncomeExpenseReport &&
        from == other.from &&
        to == other.to &&
        months == other.months;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, months.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IncomeExpenseReport')
          ..add('from', from)
          ..add('to', to)
          ..add('months', months))
        .toString();
  }
}

class IncomeExpenseReportBuilder
    implements Builder<IncomeExpenseReport, IncomeExpenseReportBuilder> {
  _$IncomeExpenseReport? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  ListBuilder<IncomeExpenseMonth>? _months;
  ListBuilder<IncomeExpenseMonth> get months =>
      _$this._months ??= ListBuilder<IncomeExpenseMonth>();
  set months(ListBuilder<IncomeExpenseMonth>? months) =>
      _$this._months = months;

  IncomeExpenseReportBuilder() {
    IncomeExpenseReport._defaults(this);
  }

  IncomeExpenseReportBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _months = $v.months.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IncomeExpenseReport other) {
    _$v = other as _$IncomeExpenseReport;
  }

  @override
  void update(void Function(IncomeExpenseReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IncomeExpenseReport build() => _build();

  _$IncomeExpenseReport _build() {
    _$IncomeExpenseReport _$result;
    try {
      _$result = _$v ??
          _$IncomeExpenseReport._(
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'IncomeExpenseReport', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'IncomeExpenseReport', 'to'),
            months: months.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'months';
        months.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IncomeExpenseReport', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
