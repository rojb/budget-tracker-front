// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthSession extends AuthSession {
  @override
  final String accessToken;
  @override
  final User user;

  factory _$AuthSession([void Function(AuthSessionBuilder)? updates]) =>
      (AuthSessionBuilder()..update(updates))._build();

  _$AuthSession._({required this.accessToken, required this.user}) : super._();
  @override
  AuthSession rebuild(void Function(AuthSessionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthSessionBuilder toBuilder() => AuthSessionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthSession &&
        accessToken == other.accessToken &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthSession')
          ..add('accessToken', accessToken)
          ..add('user', user))
        .toString();
  }
}

class AuthSessionBuilder implements Builder<AuthSession, AuthSessionBuilder> {
  _$AuthSession? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  AuthSessionBuilder() {
    AuthSession._defaults(this);
  }

  AuthSessionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthSession other) {
    _$v = other as _$AuthSession;
  }

  @override
  void update(void Function(AuthSessionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthSession build() => _build();

  _$AuthSession _build() {
    _$AuthSession _$result;
    try {
      _$result = _$v ??
          _$AuthSession._(
            accessToken: BuiltValueNullFieldError.checkNotNull(
                accessToken, r'AuthSession', 'accessToken'),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AuthSession', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
