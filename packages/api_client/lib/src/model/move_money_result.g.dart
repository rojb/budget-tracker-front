// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_money_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MoveMoneyResult extends MoveMoneyResult {
  @override
  final String month;
  @override
  final int readyToAssignMinor;
  @override
  final EnvelopeLine from;
  @override
  final EnvelopeLine to;

  factory _$MoveMoneyResult([void Function(MoveMoneyResultBuilder)? updates]) =>
      (MoveMoneyResultBuilder()..update(updates))._build();

  _$MoveMoneyResult._(
      {required this.month,
      required this.readyToAssignMinor,
      required this.from,
      required this.to})
      : super._();
  @override
  MoveMoneyResult rebuild(void Function(MoveMoneyResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MoveMoneyResultBuilder toBuilder() => MoveMoneyResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MoveMoneyResult &&
        month == other.month &&
        readyToAssignMinor == other.readyToAssignMinor &&
        from == other.from &&
        to == other.to;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, readyToAssignMinor.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MoveMoneyResult')
          ..add('month', month)
          ..add('readyToAssignMinor', readyToAssignMinor)
          ..add('from', from)
          ..add('to', to))
        .toString();
  }
}

class MoveMoneyResultBuilder
    implements Builder<MoveMoneyResult, MoveMoneyResultBuilder> {
  _$MoveMoneyResult? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _readyToAssignMinor;
  int? get readyToAssignMinor => _$this._readyToAssignMinor;
  set readyToAssignMinor(int? readyToAssignMinor) =>
      _$this._readyToAssignMinor = readyToAssignMinor;

  EnvelopeLineBuilder? _from;
  EnvelopeLineBuilder get from => _$this._from ??= EnvelopeLineBuilder();
  set from(EnvelopeLineBuilder? from) => _$this._from = from;

  EnvelopeLineBuilder? _to;
  EnvelopeLineBuilder get to => _$this._to ??= EnvelopeLineBuilder();
  set to(EnvelopeLineBuilder? to) => _$this._to = to;

  MoveMoneyResultBuilder() {
    MoveMoneyResult._defaults(this);
  }

  MoveMoneyResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _readyToAssignMinor = $v.readyToAssignMinor;
      _from = $v.from.toBuilder();
      _to = $v.to.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MoveMoneyResult other) {
    _$v = other as _$MoveMoneyResult;
  }

  @override
  void update(void Function(MoveMoneyResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MoveMoneyResult build() => _build();

  _$MoveMoneyResult _build() {
    _$MoveMoneyResult _$result;
    try {
      _$result = _$v ??
          _$MoveMoneyResult._(
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'MoveMoneyResult', 'month'),
            readyToAssignMinor: BuiltValueNullFieldError.checkNotNull(
                readyToAssignMinor, r'MoveMoneyResult', 'readyToAssignMinor'),
            from: from.build(),
            to: to.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'from';
        from.build();
        _$failedField = 'to';
        to.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MoveMoneyResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
