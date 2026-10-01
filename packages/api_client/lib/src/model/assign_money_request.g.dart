// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_money_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignMoneyRequest extends AssignMoneyRequest {
  @override
  final String envelopeId;
  @override
  final int amountMinor;

  factory _$AssignMoneyRequest(
          [void Function(AssignMoneyRequestBuilder)? updates]) =>
      (AssignMoneyRequestBuilder()..update(updates))._build();

  _$AssignMoneyRequest._({required this.envelopeId, required this.amountMinor})
      : super._();
  @override
  AssignMoneyRequest rebuild(
          void Function(AssignMoneyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignMoneyRequestBuilder toBuilder() =>
      AssignMoneyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignMoneyRequest &&
        envelopeId == other.envelopeId &&
        amountMinor == other.amountMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelopeId.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignMoneyRequest')
          ..add('envelopeId', envelopeId)
          ..add('amountMinor', amountMinor))
        .toString();
  }
}

class AssignMoneyRequestBuilder
    implements Builder<AssignMoneyRequest, AssignMoneyRequestBuilder> {
  _$AssignMoneyRequest? _$v;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  AssignMoneyRequestBuilder() {
    AssignMoneyRequest._defaults(this);
  }

  AssignMoneyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeId = $v.envelopeId;
      _amountMinor = $v.amountMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignMoneyRequest other) {
    _$v = other as _$AssignMoneyRequest;
  }

  @override
  void update(void Function(AssignMoneyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignMoneyRequest build() => _build();

  _$AssignMoneyRequest _build() {
    final _$result = _$v ??
        _$AssignMoneyRequest._(
          envelopeId: BuiltValueNullFieldError.checkNotNull(
              envelopeId, r'AssignMoneyRequest', 'envelopeId'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'AssignMoneyRequest', 'amountMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
