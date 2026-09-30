// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Transaction extends Transaction {
  @override
  final String id;
  @override
  final TransactionDirection direction;
  @override
  final String accountId;
  @override
  final String accountName;
  @override
  final int amountMinor;
  @override
  final DateTime occurredAt;
  @override
  final String? payeeId;
  @override
  final String? payeeName;
  @override
  final String? description;
  @override
  final BuiltList<TransactionSplit> splits;
  @override
  final DateTime createdAt;

  factory _$Transaction([void Function(TransactionBuilder)? updates]) =>
      (TransactionBuilder()..update(updates))._build();

  _$Transaction._(
      {required this.id,
      required this.direction,
      required this.accountId,
      required this.accountName,
      required this.amountMinor,
      required this.occurredAt,
      this.payeeId,
      this.payeeName,
      this.description,
      required this.splits,
      required this.createdAt})
      : super._();
  @override
  Transaction rebuild(void Function(TransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionBuilder toBuilder() => TransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transaction &&
        id == other.id &&
        direction == other.direction &&
        accountId == other.accountId &&
        accountName == other.accountName &&
        amountMinor == other.amountMinor &&
        occurredAt == other.occurredAt &&
        payeeId == other.payeeId &&
        payeeName == other.payeeName &&
        description == other.description &&
        splits == other.splits &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, accountName.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, payeeId.hashCode);
    _$hash = $jc(_$hash, payeeName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, splits.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Transaction')
          ..add('id', id)
          ..add('direction', direction)
          ..add('accountId', accountId)
          ..add('accountName', accountName)
          ..add('amountMinor', amountMinor)
          ..add('occurredAt', occurredAt)
          ..add('payeeId', payeeId)
          ..add('payeeName', payeeName)
          ..add('description', description)
          ..add('splits', splits)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TransactionBuilder implements Builder<Transaction, TransactionBuilder> {
  _$Transaction? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TransactionDirection? _direction;
  TransactionDirection? get direction => _$this._direction;
  set direction(TransactionDirection? direction) =>
      _$this._direction = direction;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  String? _payeeId;
  String? get payeeId => _$this._payeeId;
  set payeeId(String? payeeId) => _$this._payeeId = payeeId;

  String? _payeeName;
  String? get payeeName => _$this._payeeName;
  set payeeName(String? payeeName) => _$this._payeeName = payeeName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<TransactionSplit>? _splits;
  ListBuilder<TransactionSplit> get splits =>
      _$this._splits ??= ListBuilder<TransactionSplit>();
  set splits(ListBuilder<TransactionSplit>? splits) => _$this._splits = splits;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  TransactionBuilder() {
    Transaction._defaults(this);
  }

  TransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _direction = $v.direction;
      _accountId = $v.accountId;
      _accountName = $v.accountName;
      _amountMinor = $v.amountMinor;
      _occurredAt = $v.occurredAt;
      _payeeId = $v.payeeId;
      _payeeName = $v.payeeName;
      _description = $v.description;
      _splits = $v.splits.toBuilder();
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Transaction other) {
    _$v = other as _$Transaction;
  }

  @override
  void update(void Function(TransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Transaction build() => _build();

  _$Transaction _build() {
    _$Transaction _$result;
    try {
      _$result = _$v ??
          _$Transaction._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Transaction', 'id'),
            direction: BuiltValueNullFieldError.checkNotNull(
                direction, r'Transaction', 'direction'),
            accountId: BuiltValueNullFieldError.checkNotNull(
                accountId, r'Transaction', 'accountId'),
            accountName: BuiltValueNullFieldError.checkNotNull(
                accountName, r'Transaction', 'accountName'),
            amountMinor: BuiltValueNullFieldError.checkNotNull(
                amountMinor, r'Transaction', 'amountMinor'),
            occurredAt: BuiltValueNullFieldError.checkNotNull(
                occurredAt, r'Transaction', 'occurredAt'),
            payeeId: payeeId,
            payeeName: payeeName,
            description: description,
            splits: splits.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Transaction', 'createdAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'splits';
        splits.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Transaction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
