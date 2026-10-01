// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_change.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransactionChange extends TransactionChange {
  @override
  final Transaction transaction;
  @override
  final BuiltList<String> affectedMonths;

  factory _$TransactionChange(
          [void Function(TransactionChangeBuilder)? updates]) =>
      (TransactionChangeBuilder()..update(updates))._build();

  _$TransactionChange._(
      {required this.transaction, required this.affectedMonths})
      : super._();
  @override
  TransactionChange rebuild(void Function(TransactionChangeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionChangeBuilder toBuilder() =>
      TransactionChangeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionChange &&
        transaction == other.transaction &&
        affectedMonths == other.affectedMonths;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transaction.hashCode);
    _$hash = $jc(_$hash, affectedMonths.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionChange')
          ..add('transaction', transaction)
          ..add('affectedMonths', affectedMonths))
        .toString();
  }
}

class TransactionChangeBuilder
    implements
        Builder<TransactionChange, TransactionChangeBuilder>,
        AffectedMonthsBuilder {
  _$TransactionChange? _$v;

  TransactionBuilder? _transaction;
  TransactionBuilder get transaction =>
      _$this._transaction ??= TransactionBuilder();
  set transaction(covariant TransactionBuilder? transaction) =>
      _$this._transaction = transaction;

  ListBuilder<String>? _affectedMonths;
  ListBuilder<String> get affectedMonths =>
      _$this._affectedMonths ??= ListBuilder<String>();
  set affectedMonths(covariant ListBuilder<String>? affectedMonths) =>
      _$this._affectedMonths = affectedMonths;

  TransactionChangeBuilder() {
    TransactionChange._defaults(this);
  }

  TransactionChangeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transaction = $v.transaction.toBuilder();
      _affectedMonths = $v.affectedMonths.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant TransactionChange other) {
    _$v = other as _$TransactionChange;
  }

  @override
  void update(void Function(TransactionChangeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionChange build() => _build();

  _$TransactionChange _build() {
    _$TransactionChange _$result;
    try {
      _$result = _$v ??
          _$TransactionChange._(
            transaction: transaction.build(),
            affectedMonths: affectedMonths.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transaction';
        transaction.build();
        _$failedField = 'affectedMonths';
        affectedMonths.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TransactionChange', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
