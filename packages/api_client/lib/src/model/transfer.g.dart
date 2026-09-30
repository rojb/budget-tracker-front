// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Transfer extends Transfer {
  @override
  final String id;
  @override
  final String fromAccountId;
  @override
  final String toAccountId;
  @override
  final int amountMinor;
  @override
  final DateTime occurredAt;
  @override
  final DateTime createdAt;

  factory _$Transfer([void Function(TransferBuilder)? updates]) =>
      (TransferBuilder()..update(updates))._build();

  _$Transfer._(
      {required this.id,
      required this.fromAccountId,
      required this.toAccountId,
      required this.amountMinor,
      required this.occurredAt,
      required this.createdAt})
      : super._();
  @override
  Transfer rebuild(void Function(TransferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferBuilder toBuilder() => TransferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transfer &&
        id == other.id &&
        fromAccountId == other.fromAccountId &&
        toAccountId == other.toAccountId &&
        amountMinor == other.amountMinor &&
        occurredAt == other.occurredAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, fromAccountId.hashCode);
    _$hash = $jc(_$hash, toAccountId.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Transfer')
          ..add('id', id)
          ..add('fromAccountId', fromAccountId)
          ..add('toAccountId', toAccountId)
          ..add('amountMinor', amountMinor)
          ..add('occurredAt', occurredAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TransferBuilder implements Builder<Transfer, TransferBuilder> {
  _$Transfer? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  TransferBuilder() {
    Transfer._defaults(this);
  }

  TransferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _fromAccountId = $v.fromAccountId;
      _toAccountId = $v.toAccountId;
      _amountMinor = $v.amountMinor;
      _occurredAt = $v.occurredAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Transfer other) {
    _$v = other as _$Transfer;
  }

  @override
  void update(void Function(TransferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Transfer build() => _build();

  _$Transfer _build() {
    final _$result = _$v ??
        _$Transfer._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Transfer', 'id'),
          fromAccountId: BuiltValueNullFieldError.checkNotNull(
              fromAccountId, r'Transfer', 'fromAccountId'),
          toAccountId: BuiltValueNullFieldError.checkNotNull(
              toAccountId, r'Transfer', 'toAccountId'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'Transfer', 'amountMinor'),
          occurredAt: BuiltValueNullFieldError.checkNotNull(
              occurredAt, r'Transfer', 'occurredAt'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Transfer', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
