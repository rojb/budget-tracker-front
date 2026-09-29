import 'package:flutter/foundation.dart';

import 'auth_controller.dart';
import 'auth_repository.dart';
import 'login_controller.dart' show SubmitOutcome;

/// Form state of screen 19 Crear cuenta.
class RegisterController extends ChangeNotifier {
  RegisterController(this._auth);

  final AuthController _auth;

  bool _loading = false;
  bool _obscurePassword = true;
  bool _disposed = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _formError;

  bool get loading => _loading;
  bool get obscurePassword => _obscurePassword;
  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get formError => _formError;

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

  void clearErrors() {
    if (_nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _formError == null) {
      return;
    }
    _nameError = _emailError = _passwordError = _formError = null;
    notifyListeners();
  }

  Future<SubmitOutcome> submit({
    required String name,
    required String email,
    required String password,
  }) async {
    if (_loading) return SubmitOutcome.rejected;
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    _nameError = trimmedName.isEmpty ? 'Ingresá tu nombre' : null;
    _emailError = !_looksLikeEmail(trimmedEmail)
        ? 'Ingresá un email válido'
        : null;
    _passwordError = password.length < 8 ? 'Usá al menos 8 caracteres' : null;
    _formError = null;
    if (_nameError != null || _emailError != null || _passwordError != null) {
      notifyListeners();
      return SubmitOutcome.rejected;
    }

    _loading = true;
    notifyListeners();
    try {
      await _auth.register(
        name: trimmedName,
        email: trimmedEmail,
        password: password,
      );
      return SubmitOutcome.success;
    } on AuthFailure catch (failure) {
      return _fail(failure);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  bool _looksLikeEmail(String value) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);

  SubmitOutcome _fail(AuthFailure failure) {
    switch (failure.kind) {
      case AuthFailureKind.emailTaken:
        _emailError = 'Ya existe una cuenta con ese email';
        return SubmitOutcome.rejected;
      case AuthFailureKind.validation:
        _nameError = failure.fieldErrors['name'];
        _emailError = failure.fieldErrors['email'];
        _passwordError = failure.fieldErrors['password'];
        _formError = failure.formErrors.isEmpty
            ? null
            : failure.formErrors.first;
        return SubmitOutcome.rejected;
      case AuthFailureKind.invalidCredentials:
      case AuthFailureKind.network:
      case AuthFailureKind.unauthorized:
      case AuthFailureKind.unexpected:
        return SubmitOutcome.connectionProblem;
    }
  }
}
