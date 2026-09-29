import 'package:flutter/foundation.dart';

import '../../core/api/api_gateway.dart';
import '../../core/session/session_storage.dart';
import 'auth_repository.dart';

enum SessionStatus {
  /// Restoring the stored token at startup.
  unknown,
  signedOut,
  signedIn,
}

/// Session state of the app: restores the stored token, signs in/up/out and
/// reacts to a `401` from the API. The router listens to it.
class AuthController extends ChangeNotifier {
  AuthController(this._repository, this._storage, this._gateway) {
    _gateway.onUnauthorized = expire;
  }

  final AuthRepository _repository;
  final SessionStorage _storage;
  final ApiGateway _gateway;

  SessionStatus _status = SessionStatus.unknown;
  AuthUser? _user;
  bool _showWelcome = false;

  SessionStatus get status => _status;
  AuthUser? get user => _user;

  /// True right after a successful sign-up, until screen 34 is left.
  bool get showWelcome => _showWelcome;

  /// Reads the stored token and validates it with `GET /users/me`. A rejected
  /// token is discarded; an unreachable API keeps the session (the first call
  /// that gets a `401` will expire it).
  Future<void> restore() async {
    final token = await _storage.readToken();
    if (token == null) {
      _set(SessionStatus.signedOut);
      return;
    }
    _gateway.setToken(token);
    try {
      _user = await _repository.currentUser();
      _set(SessionStatus.signedIn);
    } on AuthFailure catch (failure) {
      if (failure.kind == AuthFailureKind.network) {
        _set(SessionStatus.signedIn);
      } else {
        await _clear();
      }
    }
  }

  /// Throws [AuthFailure] on failure.
  Future<void> login({required String email, required String password}) async {
    final session = await _repository.login(email: email, password: password);
    await _start(session);
  }

  /// Throws [AuthFailure] on failure. On success the welcome screen is due.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final session = await _repository.register(
      name: name,
      email: email,
      password: password,
    );
    _showWelcome = true;
    await _start(session);
  }

  /// Ends the session: deletes the token and returns to the sign-in screen.
  Future<void> logout() => _clear();

  /// A secured call was rejected with `401`.
  Future<void> expire() async {
    if (_status == SessionStatus.signedIn) await _clear();
  }

  /// Leaves screen 34 without notifying, so the router keeps the destination
  /// the user just picked.
  void consumeWelcome() => _showWelcome = false;

  Future<void> _start(AuthSessionData session) async {
    await _storage.writeToken(session.token);
    _gateway.setToken(session.token);
    _user = session.user;
    _set(SessionStatus.signedIn);
  }

  Future<void> _clear() async {
    await _storage.deleteToken();
    _gateway.setToken(null);
    _user = null;
    _showWelcome = false;
    _set(SessionStatus.signedOut);
  }

  void _set(SessionStatus status) {
    _status = status;
    notifyListeners();
  }
}
