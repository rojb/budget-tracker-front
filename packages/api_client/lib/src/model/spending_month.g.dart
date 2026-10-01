// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_month.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SpendingMonth extends SpendingMonth {
  @override
  final String month;
  @override
  final int totalMinor;
  @override
  final BuiltList<EnvelopeSpending> envelopes;

  factory _$SpendingMonth([void Function(SpendingMonthBuilder)? updates]) =>
      (SpendingMonthBuilder()..update(updates))._build();

  _$SpendingMonth._(
      {required this.month, required this.totalMinor, required this.envelopes})
      : super._();
  @override
  SpendingMonth rebuild(void Function(SpendingMonthBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SpendingMonthBuilder toBuilder() => SpendingMonthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SpendingMonth &&
        month == other.month &&
        totalMinor == other.totalMinor &&
        envelopes == other.envelopes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, totalMinor.hashCode);
    _$hash = $jc(_$hash, envelopes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SpendingMonth')
          ..add('month', month)
          ..add('totalMinor', totalMinor)
          ..add('envelopes', envelopes))
        .toString();
  }
}

class SpendingMonthBuilder
    implements Builder<SpendingMonth, SpendingMonthBuilder> {
  _$SpendingMonth? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _totalMinor;
  int? get totalMinor => _$this._totalMinor;
  set totalMinor(int? totalMinor) => _$this._totalMinor = totalMinor;

  ListBuilder<EnvelopeSpending>? _envelopes;
  ListBuilder<EnvelopeSpending> get envelopes =>
      _$this._envelopes ??= ListBuilder<EnvelopeSpending>();
  set envelopes(ListBuilder<EnvelopeSpending>? envelopes) =>
      _$this._envelopes = envelopes;

  SpendingMonthBuilder() {
    SpendingMonth._defaults(this);
  }

  SpendingMonthBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _totalMinor = $v.totalMinor;
      _envelopes = $v.envelopes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SpendingMonth other) {
    _$v = other as _$SpendingMonth;
  }

  @override
  void update(void Function(SpendingMonthBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SpendingMonth build() => _build();

  _$SpendingMonth _build() {
    _$SpendingMonth _$result;
    try {
      _$result = _$v ??
          _$SpendingMonth._(
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'SpendingMonth', 'month'),
            totalMinor: BuiltValueNullFieldError.checkNotNull(
                totalMinor, r'SpendingMonth', 'totalMinor'),
            envelopes: envelopes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'envelopes';
        envelopes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SpendingMonth', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
