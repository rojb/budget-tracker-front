// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transaction_split.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateTransactionSplit extends CreateTransactionSplit {
  @override
  final String envelopeId;
  @override
  final int amountMinor;

  factory _$CreateTransactionSplit(
          [void Function(CreateTransactionSplitBuilder)? updates]) =>
      (CreateTransactionSplitBuilder()..update(updates))._build();

  _$CreateTransactionSplit._(
      {required this.envelopeId, required this.amountMinor})
      : super._();
  @override
  CreateTransactionSplit rebuild(
          void Function(CreateTransactionSplitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateTransactionSplitBuilder toBuilder() =>
      CreateTransactionSplitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateTransactionSplit &&
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
    return (newBuiltValueToStringHelper(r'CreateTransactionSplit')
          ..add('envelopeId', envelopeId)
          ..add('amountMinor', amountMinor))
        .toString();
  }
}

class CreateTransactionSplitBuilder
    implements Builder<CreateTransactionSplit, CreateTransactionSplitBuilder> {
  _$CreateTransactionSplit? _$v;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  CreateTransactionSplitBuilder() {
    CreateTransactionSplit._defaults(this);
  }

  CreateTransactionSplitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeId = $v.envelopeId;
      _amountMinor = $v.amountMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateTransactionSplit other) {
    _$v = other as _$CreateTransactionSplit;
  }

  @override
  void update(void Function(CreateTransactionSplitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateTransactionSplit build() => _build();

  _$CreateTransactionSplit _build() {
    final _$result = _$v ??
        _$CreateTransactionSplit._(
          envelopeId: BuiltValueNullFieldError.checkNotNull(
              envelopeId, r'CreateTransactionSplit', 'envelopeId'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'CreateTransactionSplit', 'amountMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
