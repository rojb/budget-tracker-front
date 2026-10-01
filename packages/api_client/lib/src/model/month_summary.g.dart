// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonthSummary extends MonthSummary {
  @override
  final String month;
  @override
  final String currentMonth;
  @override
  final bool isFuture;
  @override
  final int balanceMinor;
  @override
  final int availableMinor;
  @override
  final int futureAssignedMinor;
  @override
  final int readyToAssignMinor;
  @override
  final int assignedMinor;
  @override
  final int envelopeCount;
  @override
  final int overspentCount;
  @override
  final int underfundedCount;
  @override
  final int fundedCount;

  factory _$MonthSummary([void Function(MonthSummaryBuilder)? updates]) =>
      (MonthSummaryBuilder()..update(updates))._build();

  _$MonthSummary._(
      {required this.month,
      required this.currentMonth,
      required this.isFuture,
      required this.balanceMinor,
      required this.availableMinor,
      required this.futureAssignedMinor,
      required this.readyToAssignMinor,
      required this.assignedMinor,
      required this.envelopeCount,
      required this.overspentCount,
      required this.underfundedCount,
      required this.fundedCount})
      : super._();
  @override
  MonthSummary rebuild(void Function(MonthSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonthSummaryBuilder toBuilder() => MonthSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonthSummary &&
        month == other.month &&
        currentMonth == other.currentMonth &&
        isFuture == other.isFuture &&
        balanceMinor == other.balanceMinor &&
        availableMinor == other.availableMinor &&
        futureAssignedMinor == other.futureAssignedMinor &&
        readyToAssignMinor == other.readyToAssignMinor &&
        assignedMinor == other.assignedMinor &&
        envelopeCount == other.envelopeCount &&
        overspentCount == other.overspentCount &&
        underfundedCount == other.underfundedCount &&
        fundedCount == other.fundedCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, currentMonth.hashCode);
    _$hash = $jc(_$hash, isFuture.hashCode);
    _$hash = $jc(_$hash, balanceMinor.hashCode);
    _$hash = $jc(_$hash, availableMinor.hashCode);
    _$hash = $jc(_$hash, futureAssignedMinor.hashCode);
    _$hash = $jc(_$hash, readyToAssignMinor.hashCode);
    _$hash = $jc(_$hash, assignedMinor.hashCode);
    _$hash = $jc(_$hash, envelopeCount.hashCode);
    _$hash = $jc(_$hash, overspentCount.hashCode);
    _$hash = $jc(_$hash, underfundedCount.hashCode);
    _$hash = $jc(_$hash, fundedCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonthSummary')
          ..add('month', month)
          ..add('currentMonth', currentMonth)
          ..add('isFuture', isFuture)
          ..add('balanceMinor', balanceMinor)
          ..add('availableMinor', availableMinor)
          ..add('futureAssignedMinor', futureAssignedMinor)
          ..add('readyToAssignMinor', readyToAssignMinor)
          ..add('assignedMinor', assignedMinor)
          ..add('envelopeCount', envelopeCount)
          ..add('overspentCount', overspentCount)
          ..add('underfundedCount', underfundedCount)
          ..add('fundedCount', fundedCount))
        .toString();
  }
}

class MonthSummaryBuilder
    implements Builder<MonthSummary, MonthSummaryBuilder> {
  _$MonthSummary? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  String? _currentMonth;
  String? get currentMonth => _$this._currentMonth;
  set currentMonth(String? currentMonth) => _$this._currentMonth = currentMonth;

  bool? _isFuture;
  bool? get isFuture => _$this._isFuture;
  set isFuture(bool? isFuture) => _$this._isFuture = isFuture;

  int? _balanceMinor;
  int? get balanceMinor => _$this._balanceMinor;
  set balanceMinor(int? balanceMinor) => _$this._balanceMinor = balanceMinor;

  int? _availableMinor;
  int? get availableMinor => _$this._availableMinor;
  set availableMinor(int? availableMinor) =>
      _$this._availableMinor = availableMinor;

  int? _futureAssignedMinor;
  int? get futureAssignedMinor => _$this._futureAssignedMinor;
  set futureAssignedMinor(int? futureAssignedMinor) =>
      _$this._futureAssignedMinor = futureAssignedMinor;

  int? _readyToAssignMinor;
  int? get readyToAssignMinor => _$this._readyToAssignMinor;
  set readyToAssignMinor(int? readyToAssignMinor) =>
      _$this._readyToAssignMinor = readyToAssignMinor;

  int? _assignedMinor;
  int? get assignedMinor => _$this._assignedMinor;
  set assignedMinor(int? assignedMinor) =>
      _$this._assignedMinor = assignedMinor;

  int? _envelopeCount;
  int? get envelopeCount => _$this._envelopeCount;
  set envelopeCount(int? envelopeCount) =>
      _$this._envelopeCount = envelopeCount;

  int? _overspentCount;
  int? get overspentCount => _$this._overspentCount;
  set overspentCount(int? overspentCount) =>
      _$this._overspentCount = overspentCount;

  int? _underfundedCount;
  int? get underfundedCount => _$this._underfundedCount;
  set underfundedCount(int? underfundedCount) =>
      _$this._underfundedCount = underfundedCount;

  int? _fundedCount;
  int? get fundedCount => _$this._fundedCount;
  set fundedCount(int? fundedCount) => _$this._fundedCount = fundedCount;

  MonthSummaryBuilder() {
    MonthSummary._defaults(this);
  }

  MonthSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _currentMonth = $v.currentMonth;
      _isFuture = $v.isFuture;
      _balanceMinor = $v.balanceMinor;
      _availableMinor = $v.availableMinor;
      _futureAssignedMinor = $v.futureAssignedMinor;
      _readyToAssignMinor = $v.readyToAssignMinor;
      _assignedMinor = $v.assignedMinor;
      _envelopeCount = $v.envelopeCount;
      _overspentCount = $v.overspentCount;
      _underfundedCount = $v.underfundedCount;
      _fundedCount = $v.fundedCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonthSummary other) {
    _$v = other as _$MonthSummary;
  }

  @override
  void update(void Function(MonthSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonthSummary build() => _build();

  _$MonthSummary _build() {
    final _$result = _$v ??
        _$MonthSummary._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'MonthSummary', 'month'),
          currentMonth: BuiltValueNullFieldError.checkNotNull(
              currentMonth, r'MonthSummary', 'currentMonth'),
          isFuture: BuiltValueNullFieldError.checkNotNull(
              isFuture, r'MonthSummary', 'isFuture'),
          balanceMinor: BuiltValueNullFieldError.checkNotNull(
              balanceMinor, r'MonthSummary', 'balanceMinor'),
          availableMinor: BuiltValueNullFieldError.checkNotNull(
              availableMinor, r'MonthSummary', 'availableMinor'),
          futureAssignedMinor: BuiltValueNullFieldError.checkNotNull(
              futureAssignedMinor, r'MonthSummary', 'futureAssignedMinor'),
          readyToAssignMinor: BuiltValueNullFieldError.checkNotNull(
              readyToAssignMinor, r'MonthSummary', 'readyToAssignMinor'),
          assignedMinor: BuiltValueNullFieldError.checkNotNull(
              assignedMinor, r'MonthSummary', 'assignedMinor'),
          envelopeCount: BuiltValueNullFieldError.checkNotNull(
              envelopeCount, r'MonthSummary', 'envelopeCount'),
          overspentCount: BuiltValueNullFieldError.checkNotNull(
              overspentCount, r'MonthSummary', 'overspentCount'),
          underfundedCount: BuiltValueNullFieldError.checkNotNull(
              underfundedCount, r'MonthSummary', 'underfundedCount'),
          fundedCount: BuiltValueNullFieldError.checkNotNull(
              fundedCount, r'MonthSummary', 'fundedCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
