// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransactionSummary extends TransactionSummary {
  @override
  final int outflowMinor;
  @override
  final int inflowMinor;

  factory _$TransactionSummary(
          [void Function(TransactionSummaryBuilder)? updates]) =>
      (TransactionSummaryBuilder()..update(updates))._build();

  _$TransactionSummary._(
      {required this.outflowMinor, required this.inflowMinor})
      : super._();
  @override
  TransactionSummary rebuild(
          void Function(TransactionSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionSummaryBuilder toBuilder() =>
      TransactionSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionSummary &&
        outflowMinor == other.outflowMinor &&
        inflowMinor == other.inflowMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, outflowMinor.hashCode);
    _$hash = $jc(_$hash, inflowMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionSummary')
          ..add('outflowMinor', outflowMinor)
          ..add('inflowMinor', inflowMinor))
        .toString();
  }
}

class TransactionSummaryBuilder
    implements Builder<TransactionSummary, TransactionSummaryBuilder> {
  _$TransactionSummary? _$v;

  int? _outflowMinor;
  int? get outflowMinor => _$this._outflowMinor;
  set outflowMinor(int? outflowMinor) => _$this._outflowMinor = outflowMinor;

  int? _inflowMinor;
  int? get inflowMinor => _$this._inflowMinor;
  set inflowMinor(int? inflowMinor) => _$this._inflowMinor = inflowMinor;

  TransactionSummaryBuilder() {
    TransactionSummary._defaults(this);
  }

  TransactionSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _outflowMinor = $v.outflowMinor;
      _inflowMinor = $v.inflowMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionSummary other) {
    _$v = other as _$TransactionSummary;
  }

  @override
  void update(void Function(TransactionSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionSummary build() => _build();

  _$TransactionSummary _build() {
    final _$result = _$v ??
        _$TransactionSummary._(
          outflowMinor: BuiltValueNullFieldError.checkNotNull(
              outflowMinor, r'TransactionSummary', 'outflowMinor'),
          inflowMinor: BuiltValueNullFieldError.checkNotNull(
              inflowMinor, r'TransactionSummary', 'inflowMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
