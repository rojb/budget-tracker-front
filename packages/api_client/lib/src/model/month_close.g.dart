// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_close.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonthClose extends MonthClose {
  @override
  final String fromMonth;
  @override
  final String toMonth;
  @override
  final BuiltList<CloseLine> carried;
  @override
  final BuiltList<CloseLine> deducted;
  @override
  final int totalDeductedMinor;
  @override
  final int readyToAssignFromMinor;
  @override
  final int readyToAssignToMinor;
  @override
  final int balanceMinor;
  @override
  final int availableMinor;
  @override
  final int futureAssignedMinor;
  @override
  final bool confirmed;

  factory _$MonthClose([void Function(MonthCloseBuilder)? updates]) =>
      (MonthCloseBuilder()..update(updates))._build();

  _$MonthClose._(
      {required this.fromMonth,
      required this.toMonth,
      required this.carried,
      required this.deducted,
      required this.totalDeductedMinor,
      required this.readyToAssignFromMinor,
      required this.readyToAssignToMinor,
      required this.balanceMinor,
      required this.availableMinor,
      required this.futureAssignedMinor,
      required this.confirmed})
      : super._();
  @override
  MonthClose rebuild(void Function(MonthCloseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonthCloseBuilder toBuilder() => MonthCloseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonthClose &&
        fromMonth == other.fromMonth &&
        toMonth == other.toMonth &&
        carried == other.carried &&
        deducted == other.deducted &&
        totalDeductedMinor == other.totalDeductedMinor &&
        readyToAssignFromMinor == other.readyToAssignFromMinor &&
        readyToAssignToMinor == other.readyToAssignToMinor &&
        balanceMinor == other.balanceMinor &&
        availableMinor == other.availableMinor &&
        futureAssignedMinor == other.futureAssignedMinor &&
        confirmed == other.confirmed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fromMonth.hashCode);
    _$hash = $jc(_$hash, toMonth.hashCode);
    _$hash = $jc(_$hash, carried.hashCode);
    _$hash = $jc(_$hash, deducted.hashCode);
    _$hash = $jc(_$hash, totalDeductedMinor.hashCode);
    _$hash = $jc(_$hash, readyToAssignFromMinor.hashCode);
    _$hash = $jc(_$hash, readyToAssignToMinor.hashCode);
    _$hash = $jc(_$hash, balanceMinor.hashCode);
    _$hash = $jc(_$hash, availableMinor.hashCode);
    _$hash = $jc(_$hash, futureAssignedMinor.hashCode);
    _$hash = $jc(_$hash, confirmed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonthClose')
          ..add('fromMonth', fromMonth)
          ..add('toMonth', toMonth)
          ..add('carried', carried)
          ..add('deducted', deducted)
          ..add('totalDeductedMinor', totalDeductedMinor)
          ..add('readyToAssignFromMinor', readyToAssignFromMinor)
          ..add('readyToAssignToMinor', readyToAssignToMinor)
          ..add('balanceMinor', balanceMinor)
          ..add('availableMinor', availableMinor)
          ..add('futureAssignedMinor', futureAssignedMinor)
          ..add('confirmed', confirmed))
        .toString();
  }
}

class MonthCloseBuilder implements Builder<MonthClose, MonthCloseBuilder> {
  _$MonthClose? _$v;

  String? _fromMonth;
  String? get fromMonth => _$this._fromMonth;
  set fromMonth(String? fromMonth) => _$this._fromMonth = fromMonth;

  String? _toMonth;
  String? get toMonth => _$this._toMonth;
  set toMonth(String? toMonth) => _$this._toMonth = toMonth;

  ListBuilder<CloseLine>? _carried;
  ListBuilder<CloseLine> get carried =>
      _$this._carried ??= ListBuilder<CloseLine>();
  set carried(ListBuilder<CloseLine>? carried) => _$this._carried = carried;

  ListBuilder<CloseLine>? _deducted;
  ListBuilder<CloseLine> get deducted =>
      _$this._deducted ??= ListBuilder<CloseLine>();
  set deducted(ListBuilder<CloseLine>? deducted) => _$this._deducted = deducted;

  int? _totalDeductedMinor;
  int? get totalDeductedMinor => _$this._totalDeductedMinor;
  set totalDeductedMinor(int? totalDeductedMinor) =>
      _$this._totalDeductedMinor = totalDeductedMinor;

  int? _readyToAssignFromMinor;
  int? get readyToAssignFromMinor => _$this._readyToAssignFromMinor;
  set readyToAssignFromMinor(int? readyToAssignFromMinor) =>
      _$this._readyToAssignFromMinor = readyToAssignFromMinor;

  int? _readyToAssignToMinor;
  int? get readyToAssignToMinor => _$this._readyToAssignToMinor;
  set readyToAssignToMinor(int? readyToAssignToMinor) =>
      _$this._readyToAssignToMinor = readyToAssignToMinor;

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

  bool? _confirmed;
  bool? get confirmed => _$this._confirmed;
  set confirmed(bool? confirmed) => _$this._confirmed = confirmed;

  MonthCloseBuilder() {
    MonthClose._defaults(this);
  }

  MonthCloseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fromMonth = $v.fromMonth;
      _toMonth = $v.toMonth;
      _carried = $v.carried.toBuilder();
      _deducted = $v.deducted.toBuilder();
      _totalDeductedMinor = $v.totalDeductedMinor;
      _readyToAssignFromMinor = $v.readyToAssignFromMinor;
      _readyToAssignToMinor = $v.readyToAssignToMinor;
      _balanceMinor = $v.balanceMinor;
      _availableMinor = $v.availableMinor;
      _futureAssignedMinor = $v.futureAssignedMinor;
      _confirmed = $v.confirmed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonthClose other) {
    _$v = other as _$MonthClose;
  }

  @override
  void update(void Function(MonthCloseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonthClose build() => _build();

  _$MonthClose _build() {
    _$MonthClose _$result;
    try {
      _$result = _$v ??
          _$MonthClose._(
            fromMonth: BuiltValueNullFieldError.checkNotNull(
                fromMonth, r'MonthClose', 'fromMonth'),
            toMonth: BuiltValueNullFieldError.checkNotNull(
                toMonth, r'MonthClose', 'toMonth'),
            carried: carried.build(),
            deducted: deducted.build(),
            totalDeductedMinor: BuiltValueNullFieldError.checkNotNull(
                totalDeductedMinor, r'MonthClose', 'totalDeductedMinor'),
            readyToAssignFromMinor: BuiltValueNullFieldError.checkNotNull(
                readyToAssignFromMinor,
                r'MonthClose',
                'readyToAssignFromMinor'),
            readyToAssignToMinor: BuiltValueNullFieldError.checkNotNull(
                readyToAssignToMinor, r'MonthClose', 'readyToAssignToMinor'),
            balanceMinor: BuiltValueNullFieldError.checkNotNull(
                balanceMinor, r'MonthClose', 'balanceMinor'),
            availableMinor: BuiltValueNullFieldError.checkNotNull(
                availableMinor, r'MonthClose', 'availableMinor'),
            futureAssignedMinor: BuiltValueNullFieldError.checkNotNull(
                futureAssignedMinor, r'MonthClose', 'futureAssignedMinor'),
            confirmed: BuiltValueNullFieldError.checkNotNull(
                confirmed, r'MonthClose', 'confirmed'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'carried';
        carried.build();
        _$failedField = 'deducted';
        deducted.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MonthClose', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
