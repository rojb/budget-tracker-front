// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_money_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignMoneyResult extends AssignMoneyResult {
  @override
  final String month;
  @override
  final int readyToAssignMinor;
  @override
  final EnvelopeLine line;

  factory _$AssignMoneyResult(
          [void Function(AssignMoneyResultBuilder)? updates]) =>
      (AssignMoneyResultBuilder()..update(updates))._build();

  _$AssignMoneyResult._(
      {required this.month,
      required this.readyToAssignMinor,
      required this.line})
      : super._();
  @override
  AssignMoneyResult rebuild(void Function(AssignMoneyResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignMoneyResultBuilder toBuilder() =>
      AssignMoneyResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignMoneyResult &&
        month == other.month &&
        readyToAssignMinor == other.readyToAssignMinor &&
        line == other.line;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, readyToAssignMinor.hashCode);
    _$hash = $jc(_$hash, line.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignMoneyResult')
          ..add('month', month)
          ..add('readyToAssignMinor', readyToAssignMinor)
          ..add('line', line))
        .toString();
  }
}

class AssignMoneyResultBuilder
    implements Builder<AssignMoneyResult, AssignMoneyResultBuilder> {
  _$AssignMoneyResult? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _readyToAssignMinor;
  int? get readyToAssignMinor => _$this._readyToAssignMinor;
  set readyToAssignMinor(int? readyToAssignMinor) =>
      _$this._readyToAssignMinor = readyToAssignMinor;

  EnvelopeLineBuilder? _line;
  EnvelopeLineBuilder get line => _$this._line ??= EnvelopeLineBuilder();
  set line(EnvelopeLineBuilder? line) => _$this._line = line;

  AssignMoneyResultBuilder() {
    AssignMoneyResult._defaults(this);
  }

  AssignMoneyResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _readyToAssignMinor = $v.readyToAssignMinor;
      _line = $v.line.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignMoneyResult other) {
    _$v = other as _$AssignMoneyResult;
  }

  @override
  void update(void Function(AssignMoneyResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignMoneyResult build() => _build();

  _$AssignMoneyResult _build() {
    _$AssignMoneyResult _$result;
    try {
      _$result = _$v ??
          _$AssignMoneyResult._(
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'AssignMoneyResult', 'month'),
            readyToAssignMinor: BuiltValueNullFieldError.checkNotNull(
                readyToAssignMinor, r'AssignMoneyResult', 'readyToAssignMinor'),
            line: line.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'line';
        line.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AssignMoneyResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
