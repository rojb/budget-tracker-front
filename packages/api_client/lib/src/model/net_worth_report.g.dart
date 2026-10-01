// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_worth_report.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NetWorthReport extends NetWorthReport {
  @override
  final String from;
  @override
  final String to;
  @override
  final BuiltList<NetWorthMonth> months;

  factory _$NetWorthReport([void Function(NetWorthReportBuilder)? updates]) =>
      (NetWorthReportBuilder()..update(updates))._build();

  _$NetWorthReport._(
      {required this.from, required this.to, required this.months})
      : super._();
  @override
  NetWorthReport rebuild(void Function(NetWorthReportBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetWorthReportBuilder toBuilder() => NetWorthReportBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetWorthReport &&
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
    return (newBuiltValueToStringHelper(r'NetWorthReport')
          ..add('from', from)
          ..add('to', to)
          ..add('months', months))
        .toString();
  }
}

class NetWorthReportBuilder
    implements Builder<NetWorthReport, NetWorthReportBuilder> {
  _$NetWorthReport? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  ListBuilder<NetWorthMonth>? _months;
  ListBuilder<NetWorthMonth> get months =>
      _$this._months ??= ListBuilder<NetWorthMonth>();
  set months(ListBuilder<NetWorthMonth>? months) => _$this._months = months;

  NetWorthReportBuilder() {
    NetWorthReport._defaults(this);
  }

  NetWorthReportBuilder get _$this {
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
  void replace(NetWorthReport other) {
    _$v = other as _$NetWorthReport;
  }

  @override
  void update(void Function(NetWorthReportBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NetWorthReport build() => _build();

  _$NetWorthReport _build() {
    _$NetWorthReport _$result;
    try {
      _$result = _$v ??
          _$NetWorthReport._(
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'NetWorthReport', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'NetWorthReport', 'to'),
            months: months.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'months';
        months.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NetWorthReport', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
