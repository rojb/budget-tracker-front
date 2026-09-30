// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transfer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateTransferRequest extends CreateTransferRequest {
  @override
  final String fromAccountId;
  @override
  final String toAccountId;
  @override
  final int amountMinor;
  @override
  final DateTime occurredAt;

  factory _$CreateTransferRequest(
          [void Function(CreateTransferRequestBuilder)? updates]) =>
      (CreateTransferRequestBuilder()..update(updates))._build();

  _$CreateTransferRequest._(
      {required this.fromAccountId,
      required this.toAccountId,
      required this.amountMinor,
      required this.occurredAt})
      : super._();
  @override
  CreateTransferRequest rebuild(
          void Function(CreateTransferRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateTransferRequestBuilder toBuilder() =>
      CreateTransferRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateTransferRequest &&
        fromAccountId == other.fromAccountId &&
        toAccountId == other.toAccountId &&
        amountMinor == other.amountMinor &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fromAccountId.hashCode);
    _$hash = $jc(_$hash, toAccountId.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateTransferRequest')
          ..add('fromAccountId', fromAccountId)
          ..add('toAccountId', toAccountId)
          ..add('amountMinor', amountMinor)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class CreateTransferRequestBuilder
    implements Builder<CreateTransferRequest, CreateTransferRequestBuilder> {
  _$CreateTransferRequest? _$v;

  String? _fromAccountId;
  String? get fromAccountId => _$this._fromAccountId;
  set fromAccountId(String? fromAccountId) =>
      _$this._fromAccountId = fromAccountId;

  String? _toAccountId;
  String? get toAccountId => _$this._toAccountId;
  set toAccountId(String? toAccountId) => _$this._toAccountId = toAccountId;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  CreateTransferRequestBuilder() {
    CreateTransferRequest._defaults(this);
  }

  CreateTransferRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fromAccountId = $v.fromAccountId;
      _toAccountId = $v.toAccountId;
      _amountMinor = $v.amountMinor;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateTransferRequest other) {
    _$v = other as _$CreateTransferRequest;
  }

  @override
  void update(void Function(CreateTransferRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateTransferRequest build() => _build();

  _$CreateTransferRequest _build() {
    final _$result = _$v ??
        _$CreateTransferRequest._(
          fromAccountId: BuiltValueNullFieldError.checkNotNull(
              fromAccountId, r'CreateTransferRequest', 'fromAccountId'),
          toAccountId: BuiltValueNullFieldError.checkNotNull(
              toAccountId, r'CreateTransferRequest', 'toAccountId'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'CreateTransferRequest', 'amountMinor'),
          occurredAt: BuiltValueNullFieldError.checkNotNull(
              occurredAt, r'CreateTransferRequest', 'occurredAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
