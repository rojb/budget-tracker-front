// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeDetail extends EnvelopeDetail {
  @override
  final String month;
  @override
  final EnvelopeLine line;
  @override
  final int carryoverMinor;
  @override
  final BuiltList<Transaction> activity;
  @override
  final int activityTotal;

  factory _$EnvelopeDetail([void Function(EnvelopeDetailBuilder)? updates]) =>
      (EnvelopeDetailBuilder()..update(updates))._build();

  _$EnvelopeDetail._(
      {required this.month,
      required this.line,
      required this.carryoverMinor,
      required this.activity,
      required this.activityTotal})
      : super._();
  @override
  EnvelopeDetail rebuild(void Function(EnvelopeDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeDetailBuilder toBuilder() => EnvelopeDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeDetail &&
        month == other.month &&
        line == other.line &&
        carryoverMinor == other.carryoverMinor &&
        activity == other.activity &&
        activityTotal == other.activityTotal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, line.hashCode);
    _$hash = $jc(_$hash, carryoverMinor.hashCode);
    _$hash = $jc(_$hash, activity.hashCode);
    _$hash = $jc(_$hash, activityTotal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeDetail')
          ..add('month', month)
          ..add('line', line)
          ..add('carryoverMinor', carryoverMinor)
          ..add('activity', activity)
          ..add('activityTotal', activityTotal))
        .toString();
  }
}

class EnvelopeDetailBuilder
    implements Builder<EnvelopeDetail, EnvelopeDetailBuilder> {
  _$EnvelopeDetail? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  EnvelopeLineBuilder? _line;
  EnvelopeLineBuilder get line => _$this._line ??= EnvelopeLineBuilder();
  set line(EnvelopeLineBuilder? line) => _$this._line = line;

  int? _carryoverMinor;
  int? get carryoverMinor => _$this._carryoverMinor;
  set carryoverMinor(int? carryoverMinor) =>
      _$this._carryoverMinor = carryoverMinor;

  ListBuilder<Transaction>? _activity;
  ListBuilder<Transaction> get activity =>
      _$this._activity ??= ListBuilder<Transaction>();
  set activity(ListBuilder<Transaction>? activity) =>
      _$this._activity = activity;

  int? _activityTotal;
  int? get activityTotal => _$this._activityTotal;
  set activityTotal(int? activityTotal) =>
      _$this._activityTotal = activityTotal;

  EnvelopeDetailBuilder() {
    EnvelopeDetail._defaults(this);
  }

  EnvelopeDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _line = $v.line.toBuilder();
      _carryoverMinor = $v.carryoverMinor;
      _activity = $v.activity.toBuilder();
      _activityTotal = $v.activityTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeDetail other) {
    _$v = other as _$EnvelopeDetail;
  }

  @override
  void update(void Function(EnvelopeDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeDetail build() => _build();

  _$EnvelopeDetail _build() {
    _$EnvelopeDetail _$result;
    try {
      _$result = _$v ??
          _$EnvelopeDetail._(
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'EnvelopeDetail', 'month'),
            line: line.build(),
            carryoverMinor: BuiltValueNullFieldError.checkNotNull(
                carryoverMinor, r'EnvelopeDetail', 'carryoverMinor'),
            activity: activity.build(),
            activityTotal: BuiltValueNullFieldError.checkNotNull(
                activityTotal, r'EnvelopeDetail', 'activityTotal'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'line';
        line.build();

        _$failedField = 'activity';
        activity.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EnvelopeDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
