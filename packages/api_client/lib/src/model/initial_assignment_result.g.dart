// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_assignment_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InitialAssignmentResult extends InitialAssignmentResult {
  @override
  final String month;
  @override
  final int assignedMinor;
  @override
  final int readyToAssignMinor;

  factory _$InitialAssignmentResult(
          [void Function(InitialAssignmentResultBuilder)? updates]) =>
      (InitialAssignmentResultBuilder()..update(updates))._build();

  _$InitialAssignmentResult._(
      {required this.month,
      required this.assignedMinor,
      required this.readyToAssignMinor})
      : super._();
  @override
  InitialAssignmentResult rebuild(
          void Function(InitialAssignmentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InitialAssignmentResultBuilder toBuilder() =>
      InitialAssignmentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InitialAssignmentResult &&
        month == other.month &&
        assignedMinor == other.assignedMinor &&
        readyToAssignMinor == other.readyToAssignMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, assignedMinor.hashCode);
    _$hash = $jc(_$hash, readyToAssignMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InitialAssignmentResult')
          ..add('month', month)
          ..add('assignedMinor', assignedMinor)
          ..add('readyToAssignMinor', readyToAssignMinor))
        .toString();
  }
}

class InitialAssignmentResultBuilder
    implements
        Builder<InitialAssignmentResult, InitialAssignmentResultBuilder> {
  _$InitialAssignmentResult? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _assignedMinor;
  int? get assignedMinor => _$this._assignedMinor;
  set assignedMinor(int? assignedMinor) =>
      _$this._assignedMinor = assignedMinor;

  int? _readyToAssignMinor;
  int? get readyToAssignMinor => _$this._readyToAssignMinor;
  set readyToAssignMinor(int? readyToAssignMinor) =>
      _$this._readyToAssignMinor = readyToAssignMinor;

  InitialAssignmentResultBuilder() {
    InitialAssignmentResult._defaults(this);
  }

  InitialAssignmentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _assignedMinor = $v.assignedMinor;
      _readyToAssignMinor = $v.readyToAssignMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InitialAssignmentResult other) {
    _$v = other as _$InitialAssignmentResult;
  }

  @override
  void update(void Function(InitialAssignmentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InitialAssignmentResult build() => _build();

  _$InitialAssignmentResult _build() {
    final _$result = _$v ??
        _$InitialAssignmentResult._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'InitialAssignmentResult', 'month'),
          assignedMinor: BuiltValueNullFieldError.checkNotNull(
              assignedMinor, r'InitialAssignmentResult', 'assignedMinor'),
          readyToAssignMinor: BuiltValueNullFieldError.checkNotNull(
              readyToAssignMinor,
              r'InitialAssignmentResult',
              'readyToAssignMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
