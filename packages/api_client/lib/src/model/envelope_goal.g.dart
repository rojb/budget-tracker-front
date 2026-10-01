// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_goal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeGoal extends EnvelopeGoal {
  @override
  final EnvelopeGoalType type;
  @override
  final int targetMinor;
  @override
  final Date? dueDate;

  factory _$EnvelopeGoal([void Function(EnvelopeGoalBuilder)? updates]) =>
      (EnvelopeGoalBuilder()..update(updates))._build();

  _$EnvelopeGoal._(
      {required this.type, required this.targetMinor, this.dueDate})
      : super._();
  @override
  EnvelopeGoal rebuild(void Function(EnvelopeGoalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeGoalBuilder toBuilder() => EnvelopeGoalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeGoal &&
        type == other.type &&
        targetMinor == other.targetMinor &&
        dueDate == other.dueDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, targetMinor.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeGoal')
          ..add('type', type)
          ..add('targetMinor', targetMinor)
          ..add('dueDate', dueDate))
        .toString();
  }
}

class EnvelopeGoalBuilder
    implements Builder<EnvelopeGoal, EnvelopeGoalBuilder> {
  _$EnvelopeGoal? _$v;

  EnvelopeGoalType? _type;
  EnvelopeGoalType? get type => _$this._type;
  set type(EnvelopeGoalType? type) => _$this._type = type;

  int? _targetMinor;
  int? get targetMinor => _$this._targetMinor;
  set targetMinor(int? targetMinor) => _$this._targetMinor = targetMinor;

  Date? _dueDate;
  Date? get dueDate => _$this._dueDate;
  set dueDate(Date? dueDate) => _$this._dueDate = dueDate;

  EnvelopeGoalBuilder() {
    EnvelopeGoal._defaults(this);
  }

  EnvelopeGoalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _targetMinor = $v.targetMinor;
      _dueDate = $v.dueDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeGoal other) {
    _$v = other as _$EnvelopeGoal;
  }

  @override
  void update(void Function(EnvelopeGoalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeGoal build() => _build();

  _$EnvelopeGoal _build() {
    final _$result = _$v ??
        _$EnvelopeGoal._(
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'EnvelopeGoal', 'type'),
          targetMinor: BuiltValueNullFieldError.checkNotNull(
              targetMinor, r'EnvelopeGoal', 'targetMinor'),
          dueDate: dueDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
