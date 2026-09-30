// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract mixin class AccountBuilder {
  void replace(Account other);
  void update(void Function(AccountBuilder) updates);
  String? get id;
  set id(String? id);

  String? get name;
  set name(String? name);

  AccountType? get type;
  set type(AccountType? type);

  int? get openingBalanceMinor;
  set openingBalanceMinor(int? openingBalanceMinor);

  int? get balanceMinor;
  set balanceMinor(int? balanceMinor);

  bool? get archived;
  set archived(bool? archived);

  DateTime? get archivedAt;
  set archivedAt(DateTime? archivedAt);

  DateTime? get createdAt;
  set createdAt(DateTime? createdAt);
}

class _$$Account extends $Account {
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

  factory _$$Account([void Function($AccountBuilder)? updates]) =>
      ($AccountBuilder()..update(updates))._build();

  _$$Account._(
      {required this.id,
      required this.name,
      required this.type,
      required this.openingBalanceMinor,
      required this.balanceMinor,
      required this.archived,
      this.archivedAt,
      required this.createdAt})
      : super._();
  @override
  $Account rebuild(void Function($AccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $AccountBuilder toBuilder() => $AccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $Account &&
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
    return (newBuiltValueToStringHelper(r'$Account')
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

class $AccountBuilder
    implements Builder<$Account, $AccountBuilder>, AccountBuilder {
  _$$Account? _$v;

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

  $AccountBuilder() {
    $Account._defaults(this);
  }

  $AccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(covariant $Account other) {
    _$v = other as _$$Account;
  }

  @override
  void update(void Function($AccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $Account build() => _build();

  _$$Account _build() {
    final _$result = _$v ??
        _$$Account._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'$Account', 'id'),
          name:
              BuiltValueNullFieldError.checkNotNull(name, r'$Account', 'name'),
          type:
              BuiltValueNullFieldError.checkNotNull(type, r'$Account', 'type'),
          openingBalanceMinor: BuiltValueNullFieldError.checkNotNull(
              openingBalanceMinor, r'$Account', 'openingBalanceMinor'),
          balanceMinor: BuiltValueNullFieldError.checkNotNull(
              balanceMinor, r'$Account', 'balanceMinor'),
          archived: BuiltValueNullFieldError.checkNotNull(
              archived, r'$Account', 'archived'),
          archivedAt: archivedAt,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'$Account', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
