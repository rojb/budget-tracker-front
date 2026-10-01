// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SpendingReport extends SpendingReport {
  @override
  final String from;
  @override
  final String to;
  @override
  final BuiltList<SpendingMonth> months;

  factory _$SpendingReport([void Function(SpendingReportBuilder)? updates]) =>
      (SpendingReportBuilder()..update(updates))._build();

  _$SpendingReport._(
      {required this.from, required this.to, required this.months})
      : super._();
  @override
  SpendingReport rebuild(void Function(SpendingReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SpendingReportBuilder toBuilder() => SpendingReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SpendingReport &&
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
    return (newBuiltValueToStringHelper(r'SpendingReport')
          ..add('from', from)
          ..add('to', to)
          ..add('months', months))
        .toString();
  }
}

class SpendingReportBuilder
    implements Builder<SpendingReport, SpendingReportBuilder> {
  _$SpendingReport? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  ListBuilder<SpendingMonth>? _months;
  ListBuilder<SpendingMonth> get months =>
      _$this._months ??= ListBuilder<SpendingMonth>();
  set months(ListBuilder<SpendingMonth>? months) => _$this._months = months;

  SpendingReportBuilder() {
    SpendingReport._defaults(this);
  }

  SpendingReportBuilder get _$this {
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
  void replace(SpendingReport other) {
    _$v = other as _$SpendingReport;
  }

  @override
  void update(void Function(SpendingReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SpendingReport build() => _build();

  _$SpendingReport _build() {
    _$SpendingReport _$result;
    try {
      _$result = _$v ??
          _$SpendingReport._(
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'SpendingReport', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'SpendingReport', 'to'),
            months: months.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'months';
        months.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SpendingReport', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
