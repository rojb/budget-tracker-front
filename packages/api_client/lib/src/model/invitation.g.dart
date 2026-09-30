// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Invitation extends Invitation {
  @override
  final String code;
  @override
  final InvitationRole role;
  @override
  final DateTime expiresAt;
  @override
  final DateTime createdAt;
  @override
  final String link;

  factory _$Invitation([void Function(InvitationBuilder)? updates]) =>
      (InvitationBuilder()..update(updates))._build();

  _$Invitation._(
      {required this.code,
      required this.role,
      required this.expiresAt,
      required this.createdAt,
      required this.link})
      : super._();
  @override
  Invitation rebuild(void Function(InvitationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationBuilder toBuilder() => InvitationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Invitation &&
        code == other.code &&
        role == other.role &&
        expiresAt == other.expiresAt &&
        createdAt == other.createdAt &&
        link == other.link;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, link.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Invitation')
          ..add('code', code)
          ..add('role', role)
          ..add('expiresAt', expiresAt)
          ..add('createdAt', createdAt)
          ..add('link', link))
        .toString();
  }
}

class InvitationBuilder implements Builder<Invitation, InvitationBuilder> {
  _$Invitation? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  InvitationRole? _role;
  InvitationRole? get role => _$this._role;
  set role(InvitationRole? role) => _$this._role = role;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  InvitationBuilder() {
    Invitation._defaults(this);
  }

  InvitationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _role = $v.role;
      _expiresAt = $v.expiresAt;
      _createdAt = $v.createdAt;
      _link = $v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Invitation other) {
    _$v = other as _$Invitation;
  }

  @override
  void update(void Function(InvitationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Invitation build() => _build();

  _$Invitation _build() {
    final _$result = _$v ??
        _$Invitation._(
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'Invitation', 'code'),
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'Invitation', 'role'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'Invitation', 'expiresAt'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Invitation', 'createdAt'),
          link: BuiltValueNullFieldError.checkNotNull(
              link, r'Invitation', 'link'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
