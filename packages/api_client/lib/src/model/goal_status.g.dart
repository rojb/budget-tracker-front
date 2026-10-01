// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GoalStatus extends GoalStatus {
  @override
  final int requiredMinor;
  @override
  final int missingMinor;
  @override
  final int savedMinor;
  @override
  final int remainingMinor;
  @override
  final int percent;
  @override
  final int? monthsRemaining;

  factory _$GoalStatus([void Function(GoalStatusBuilder)? updates]) =>
      (GoalStatusBuilder()..update(updates))._build();

  _$GoalStatus._(
      {required this.requiredMinor,
      required this.missingMinor,
      required this.savedMinor,
      required this.remainingMinor,
      required this.percent,
      this.monthsRemaining})
      : super._();
  @override
  GoalStatus rebuild(void Function(GoalStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoalStatusBuilder toBuilder() => GoalStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GoalStatus &&
        requiredMinor == other.requiredMinor &&
        missingMinor == other.missingMinor &&
        savedMinor == other.savedMinor &&
        remainingMinor == other.remainingMinor &&
        percent == other.percent &&
        monthsRemaining == other.monthsRemaining;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, requiredMinor.hashCode);
    _$hash = $jc(_$hash, missingMinor.hashCode);
    _$hash = $jc(_$hash, savedMinor.hashCode);
    _$hash = $jc(_$hash, remainingMinor.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jc(_$hash, monthsRemaining.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GoalStatus')
          ..add('requiredMinor', requiredMinor)
          ..add('missingMinor', missingMinor)
          ..add('savedMinor', savedMinor)
          ..add('remainingMinor', remainingMinor)
          ..add('percent', percent)
          ..add('monthsRemaining', monthsRemaining))
        .toString();
  }
}

class GoalStatusBuilder implements Builder<GoalStatus, GoalStatusBuilder> {
  _$GoalStatus? _$v;

  int? _requiredMinor;
  int? get requiredMinor => _$this._requiredMinor;
  set requiredMinor(int? requiredMinor) =>
      _$this._requiredMinor = requiredMinor;

  int? _missingMinor;
  int? get missingMinor => _$this._missingMinor;
  set missingMinor(int? missingMinor) => _$this._missingMinor = missingMinor;

  int? _savedMinor;
  int? get savedMinor => _$this._savedMinor;
  set savedMinor(int? savedMinor) => _$this._savedMinor = savedMinor;

  int? _remainingMinor;
  int? get remainingMinor => _$this._remainingMinor;
  set remainingMinor(int? remainingMinor) =>
      _$this._remainingMinor = remainingMinor;

  int? _percent;
  int? get percent => _$this._percent;
  set percent(int? percent) => _$this._percent = percent;

  int? _monthsRemaining;
  int? get monthsRemaining => _$this._monthsRemaining;
  set monthsRemaining(int? monthsRemaining) =>
      _$this._monthsRemaining = monthsRemaining;

  GoalStatusBuilder() {
    GoalStatus._defaults(this);
  }

  GoalStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _requiredMinor = $v.requiredMinor;
      _missingMinor = $v.missingMinor;
      _savedMinor = $v.savedMinor;
      _remainingMinor = $v.remainingMinor;
      _percent = $v.percent;
      _monthsRemaining = $v.monthsRemaining;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GoalStatus other) {
    _$v = other as _$GoalStatus;
  }

  @override
  void update(void Function(GoalStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GoalStatus build() => _build();

  _$GoalStatus _build() {
    final _$result = _$v ??
        _$GoalStatus._(
          requiredMinor: BuiltValueNullFieldError.checkNotNull(
              requiredMinor, r'GoalStatus', 'requiredMinor'),
          missingMinor: BuiltValueNullFieldError.checkNotNull(
              missingMinor, r'GoalStatus', 'missingMinor'),
          savedMinor: BuiltValueNullFieldError.checkNotNull(
              savedMinor, r'GoalStatus', 'savedMinor'),
          remainingMinor: BuiltValueNullFieldError.checkNotNull(
              remainingMinor, r'GoalStatus', 'remainingMinor'),
          percent: BuiltValueNullFieldError.checkNotNull(
              percent, r'GoalStatus', 'percent'),
          monthsRemaining: monthsRemaining,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
