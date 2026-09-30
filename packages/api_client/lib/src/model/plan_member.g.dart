// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_member.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PlanMember extends PlanMember {
  @override
  final String userId;
  @override
  final String name;
  @override
  final String email;
  @override
  final PlanRole role;
  @override
  final DateTime joinedAt;

  factory _$PlanMember([void Function(PlanMemberBuilder)? updates]) =>
      (PlanMemberBuilder()..update(updates))._build();

  _$PlanMember._(
      {required this.userId,
      required this.name,
      required this.email,
      required this.role,
      required this.joinedAt})
      : super._();
  @override
  PlanMember rebuild(void Function(PlanMemberBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlanMemberBuilder toBuilder() => PlanMemberBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlanMember &&
        userId == other.userId &&
        name == other.name &&
        email == other.email &&
        role == other.role &&
        joinedAt == other.joinedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, joinedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlanMember')
          ..add('userId', userId)
          ..add('name', name)
          ..add('email', email)
          ..add('role', role)
          ..add('joinedAt', joinedAt))
        .toString();
  }
}

class PlanMemberBuilder implements Builder<PlanMember, PlanMemberBuilder> {
  _$PlanMember? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  PlanRole? _role;
  PlanRole? get role => _$this._role;
  set role(PlanRole? role) => _$this._role = role;

  DateTime? _joinedAt;
  DateTime? get joinedAt => _$this._joinedAt;
  set joinedAt(DateTime? joinedAt) => _$this._joinedAt = joinedAt;

  PlanMemberBuilder() {
    PlanMember._defaults(this);
  }

  PlanMemberBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _name = $v.name;
      _email = $v.email;
      _role = $v.role;
      _joinedAt = $v.joinedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlanMember other) {
    _$v = other as _$PlanMember;
  }

  @override
  void update(void Function(PlanMemberBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlanMember build() => _build();

  _$PlanMember _build() {
    final _$result = _$v ??
        _$PlanMember._(
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'PlanMember', 'userId'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'PlanMember', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'PlanMember', 'email'),
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'PlanMember', 'role'),
          joinedAt: BuiltValueNullFieldError.checkNotNull(
              joinedAt, r'PlanMember', 'joinedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
