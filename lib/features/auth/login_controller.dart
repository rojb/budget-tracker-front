import 'package:flutter/foundation.dart';

import 'auth_controller.dart';
import 'auth_repository.dart';

enum SubmitOutcome {
  /// Signed in; the router leaves the auth flow.
  success,

  /// Field or form errors are set on the controller.
  rejected,

  /// The API could not be reached or failed unexpectedly: show a toast.
  connectionProblem,
}

/// Form state of screen 18 Acceso.
class LoginController extends ChangeNotifier {
  LoginController(this._auth);

  static const String invalidCredentialsMessage =
      'Email o contraseña incorrectos. Revisalos e intentá de nuevo.';

  final AuthController _auth;

  bool _loading = false;
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;
  String? _formError;

  bool get loading => _loading;
  bool get obscurePassword => _obscurePassword;
  String? get emailError => _emailError;

  /// Empty string = Error border without a message under the field (the form
  /// message carries the text).
  String? get passwordError => _passwordError;
  String? get formError => _formError;

  bool _disposed = false;

  // The router can tear the page down as soon as the session starts, before
  // submit() finishes; skip notifications after disposal.
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Clears the errors as soon as the user edits the form again.
  void clearErrors() {
    if (_emailError == null && _passwordError == null && _formError == null) {
      return;
    }
    _emailError = null;
    _passwordError = null;
    _formError = null;
    notifyListeners();
  }

  Future<SubmitOutcome> submit({
    required String email,
    required String password,
  }) async {
    if (_loading) return SubmitOutcome.rejected;
    final trimmed = email.trim();
    _emailError = trimmed.isEmpty ? 'Ingresá tu email' : null;
    _passwordError = password.isEmpty ? 'Ingresá tu contraseña' : null;
    _formError = null;
    if (_emailError != null || _passwordError != null) {
      notifyListeners();
      return SubmitOutcome.rejected;
    }

    _loading = true;
    notifyListeners();
    try {
      await _auth.login(email: trimmed, password: password);
      return SubmitOutcome.success;
    } on AuthFailure catch (failure) {
      return _fail(failure);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  SubmitOutcome _fail(AuthFailure failure) {
    switch (failure.kind) {
      case AuthFailureKind.invalidCredentials:
        _passwordError = '';
        _formError = invalidCredentialsMessage;
        return SubmitOutcome.rejected;
      case AuthFailureKind.validation:
        _emailError = failure.fieldErrors['email'];
        _passwordError = failure.fieldErrors['password'];
        _formError = failure.formErrors.isEmpty
            ? invalidCredentialsMessage
            : failure.formErrors.first;
        return SubmitOutcome.rejected;
      case AuthFailureKind.network:
      case AuthFailureKind.unauthorized:
      case AuthFailureKind.emailTaken:
      case AuthFailureKind.unexpected:
        return SubmitOutcome.connectionProblem;
    }
  }
}
