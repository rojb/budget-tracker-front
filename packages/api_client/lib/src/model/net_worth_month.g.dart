// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_worth_month.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NetWorthMonth extends NetWorthMonth {
  @override
  final String month;
  @override
  final int balanceMinor;

  factory _$NetWorthMonth([void Function(NetWorthMonthBuilder)? updates]) =>
      (NetWorthMonthBuilder()..update(updates))._build();

  _$NetWorthMonth._({required this.month, required this.balanceMinor})
      : super._();
  @override
  NetWorthMonth rebuild(void Function(NetWorthMonthBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetWorthMonthBuilder toBuilder() => NetWorthMonthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetWorthMonth &&
        month == other.month &&
        balanceMinor == other.balanceMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, balanceMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NetWorthMonth')
          ..add('month', month)
          ..add('balanceMinor', balanceMinor))
        .toString();
  }
}

class NetWorthMonthBuilder
    implements Builder<NetWorthMonth, NetWorthMonthBuilder> {
  _$NetWorthMonth? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _balanceMinor;
  int? get balanceMinor => _$this._balanceMinor;
  set balanceMinor(int? balanceMinor) => _$this._balanceMinor = balanceMinor;

  NetWorthMonthBuilder() {
    NetWorthMonth._defaults(this);
  }

  NetWorthMonthBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _balanceMinor = $v.balanceMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetWorthMonth other) {
    _$v = other as _$NetWorthMonth;
  }

  @override
  void update(void Function(NetWorthMonthBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NetWorthMonth build() => _build();

  _$NetWorthMonth _build() {
    final _$result = _$v ??
        _$NetWorthMonth._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'NetWorthMonth', 'month'),
          balanceMinor: BuiltValueNullFieldError.checkNotNull(
              balanceMinor, r'NetWorthMonth', 'balanceMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
