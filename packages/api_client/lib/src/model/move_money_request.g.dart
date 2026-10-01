// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_money_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MoveMoneyRequest extends MoveMoneyRequest {
  @override
  final String fromEnvelopeId;
  @override
  final String toEnvelopeId;
  @override
  final int amountMinor;
  @override
  final String? month;

  factory _$MoveMoneyRequest(
          [void Function(MoveMoneyRequestBuilder)? updates]) =>
      (MoveMoneyRequestBuilder()..update(updates))._build();

  _$MoveMoneyRequest._(
      {required this.fromEnvelopeId,
      required this.toEnvelopeId,
      required this.amountMinor,
      this.month})
      : super._();
  @override
  MoveMoneyRequest rebuild(void Function(MoveMoneyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MoveMoneyRequestBuilder toBuilder() =>
      MoveMoneyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MoveMoneyRequest &&
        fromEnvelopeId == other.fromEnvelopeId &&
        toEnvelopeId == other.toEnvelopeId &&
        amountMinor == other.amountMinor &&
        month == other.month;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fromEnvelopeId.hashCode);
    _$hash = $jc(_$hash, toEnvelopeId.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MoveMoneyRequest')
          ..add('fromEnvelopeId', fromEnvelopeId)
          ..add('toEnvelopeId', toEnvelopeId)
          ..add('amountMinor', amountMinor)
          ..add('month', month))
        .toString();
  }
}

class MoveMoneyRequestBuilder
    implements Builder<MoveMoneyRequest, MoveMoneyRequestBuilder> {
  _$MoveMoneyRequest? _$v;

  String? _fromEnvelopeId;
  String? get fromEnvelopeId => _$this._fromEnvelopeId;
  set fromEnvelopeId(String? fromEnvelopeId) =>
      _$this._fromEnvelopeId = fromEnvelopeId;

  String? _toEnvelopeId;
  String? get toEnvelopeId => _$this._toEnvelopeId;
  set toEnvelopeId(String? toEnvelopeId) => _$this._toEnvelopeId = toEnvelopeId;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  MoveMoneyRequestBuilder() {
    MoveMoneyRequest._defaults(this);
  }

  MoveMoneyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fromEnvelopeId = $v.fromEnvelopeId;
      _toEnvelopeId = $v.toEnvelopeId;
      _amountMinor = $v.amountMinor;
      _month = $v.month;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MoveMoneyRequest other) {
    _$v = other as _$MoveMoneyRequest;
  }

  @override
  void update(void Function(MoveMoneyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MoveMoneyRequest build() => _build();

  _$MoveMoneyRequest _build() {
    final _$result = _$v ??
        _$MoveMoneyRequest._(
          fromEnvelopeId: BuiltValueNullFieldError.checkNotNull(
              fromEnvelopeId, r'MoveMoneyRequest', 'fromEnvelopeId'),
          toEnvelopeId: BuiltValueNullFieldError.checkNotNull(
              toEnvelopeId, r'MoveMoneyRequest', 'toEnvelopeId'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'MoveMoneyRequest', 'amountMinor'),
          month: month,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
