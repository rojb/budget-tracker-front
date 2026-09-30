// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountDetail extends AccountDetail {
  @override
  final int outflowMinor;
  @override
  final int inflowMinor;
  @override
  final String month;
  @override
  final String id;
  @override
  final String name;
  @override
  final AccountType type;
  @override
  final int openingBalanceMinor;
  @override
  final int balanceMinor;
  @override
  final bool archived;
  @override
  final DateTime? archivedAt;
  @override
  final DateTime createdAt;

  factory _$AccountDetail([void Function(AccountDetailBuilder)? updates]) =>
      (AccountDetailBuilder()..update(updates))._build();

  _$AccountDetail._(
      {required this.outflowMinor,
      required this.inflowMinor,
      required this.month,
      required this.id,
      required this.name,
      required this.type,
      required this.openingBalanceMinor,
      required this.balanceMinor,
      required this.archived,
      this.archivedAt,
      required this.createdAt})
      : super._();
  @override
  AccountDetail rebuild(void Function(AccountDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountDetailBuilder toBuilder() => AccountDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountDetail &&
        outflowMinor == other.outflowMinor &&
        inflowMinor == other.inflowMinor &&
        month == other.month &&
        id == other.id &&
        name == other.name &&
        type == other.type &&
        openingBalanceMinor == other.openingBalanceMinor &&
        balanceMinor == other.balanceMinor &&
        archived == other.archived &&
        archivedAt == other.archivedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, outflowMinor.hashCode);
    _$hash = $jc(_$hash, inflowMinor.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, openingBalanceMinor.hashCode);
    _$hash = $jc(_$hash, balanceMinor.hashCode);
    _$hash = $jc(_$hash, archived.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountDetail')
          ..add('outflowMinor', outflowMinor)
          ..add('inflowMinor', inflowMinor)
          ..add('month', month)
          ..add('id', id)
          ..add('name', name)
          ..add('type', type)
          ..add('openingBalanceMinor', openingBalanceMinor)
          ..add('balanceMinor', balanceMinor)
          ..add('archived', archived)
          ..add('archivedAt', archivedAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AccountDetailBuilder
    implements Builder<AccountDetail, AccountDetailBuilder>, AccountBuilder {
  _$AccountDetail? _$v;

  int? _outflowMinor;
  int? get outflowMinor => _$this._outflowMinor;
  set outflowMinor(covariant int? outflowMinor) =>
      _$this._outflowMinor = outflowMinor;

  int? _inflowMinor;
  int? get inflowMinor => _$this._inflowMinor;
  set inflowMinor(covariant int? inflowMinor) =>
      _$this._inflowMinor = inflowMinor;

  String? _month;
  String? get month => _$this._month;
  set month(covariant String? month) => _$this._month = month;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  AccountType? _type;
  AccountType? get type => _$this._type;
  set type(covariant AccountType? type) => _$this._type = type;

  int? _openingBalanceMinor;
  int? get openingBalanceMinor => _$this._openingBalanceMinor;
  set openingBalanceMinor(covariant int? openingBalanceMinor) =>
      _$this._openingBalanceMinor = openingBalanceMinor;

  int? _balanceMinor;
  int? get balanceMinor => _$this._balanceMinor;
  set balanceMinor(covariant int? balanceMinor) =>
      _$this._balanceMinor = balanceMinor;

  bool? _archived;
  bool? get archived => _$this._archived;
  set archived(covariant bool? archived) => _$this._archived = archived;

  DateTime? _archivedAt;
  DateTime? get archivedAt => _$this._archivedAt;
  set archivedAt(covariant DateTime? archivedAt) =>
      _$this._archivedAt = archivedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(covariant DateTime? createdAt) => _$this._createdAt = createdAt;

  AccountDetailBuilder() {
    AccountDetail._defaults(this);
  }

  AccountDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _outflowMinor = $v.outflowMinor;
      _inflowMinor = $v.inflowMinor;
      _month = $v.month;
      _id = $v.id;
      _name = $v.name;
      _type = $v.type;
      _openingBalanceMinor = $v.openingBalanceMinor;
      _balanceMinor = $v.balanceMinor;
      _archived = $v.archived;
      _archivedAt = $v.archivedAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant AccountDetail other) {
    _$v = other as _$AccountDetail;
  }

  @override
  void update(void Function(AccountDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountDetail build() => _build();

  _$AccountDetail _build() {
    final _$result = _$v ??
        _$AccountDetail._(
          outflowMinor: BuiltValueNullFieldError.checkNotNull(
              outflowMinor, r'AccountDetail', 'outflowMinor'),
          inflowMinor: BuiltValueNullFieldError.checkNotNull(
              inflowMinor, r'AccountDetail', 'inflowMinor'),
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'AccountDetail', 'month'),
          id: BuiltValueNullFieldError.checkNotNull(id, r'AccountDetail', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'AccountDetail', 'name'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'AccountDetail', 'type'),
          openingBalanceMinor: BuiltValueNullFieldError.checkNotNull(
              openingBalanceMinor, r'AccountDetail', 'openingBalanceMinor'),
          balanceMinor: BuiltValueNullFieldError.checkNotNull(
              balanceMinor, r'AccountDetail', 'balanceMinor'),
          archived: BuiltValueNullFieldError.checkNotNull(
              archived, r'AccountDetail', 'archived'),
          archivedAt: archivedAt,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'AccountDetail', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
