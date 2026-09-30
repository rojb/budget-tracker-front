// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_split.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransactionSplit extends TransactionSplit {
  @override
  final String? envelopeId;
  @override
  final String? envelopeName;
  @override
  final int amountMinor;

  factory _$TransactionSplit(
          [void Function(TransactionSplitBuilder)? updates]) =>
      (TransactionSplitBuilder()..update(updates))._build();

  _$TransactionSplit._(
      {this.envelopeId, this.envelopeName, required this.amountMinor})
      : super._();
  @override
  TransactionSplit rebuild(void Function(TransactionSplitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionSplitBuilder toBuilder() =>
      TransactionSplitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionSplit &&
        envelopeId == other.envelopeId &&
        envelopeName == other.envelopeName &&
        amountMinor == other.amountMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelopeId.hashCode);
    _$hash = $jc(_$hash, envelopeName.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionSplit')
          ..add('envelopeId', envelopeId)
          ..add('envelopeName', envelopeName)
          ..add('amountMinor', amountMinor))
        .toString();
  }
}

class TransactionSplitBuilder
    implements Builder<TransactionSplit, TransactionSplitBuilder> {
  _$TransactionSplit? _$v;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  String? _envelopeName;
  String? get envelopeName => _$this._envelopeName;
  set envelopeName(String? envelopeName) => _$this._envelopeName = envelopeName;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  TransactionSplitBuilder() {
    TransactionSplit._defaults(this);
  }

  TransactionSplitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeId = $v.envelopeId;
      _envelopeName = $v.envelopeName;
      _amountMinor = $v.amountMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionSplit other) {
    _$v = other as _$TransactionSplit;
  }

  @override
  void update(void Function(TransactionSplitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionSplit build() => _build();

  _$TransactionSplit _build() {
    final _$result = _$v ??
        _$TransactionSplit._(
          envelopeId: envelopeId,
          envelopeName: envelopeName,
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'TransactionSplit', 'amountMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
