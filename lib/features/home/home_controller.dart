import 'package:flutter/foundation.dart';

import '../auth/auth_controller.dart';

/// UI state for the signed-in home placeholder (screens 01/02 arrive with
/// `add-plans-and-accounts`). Shows who is signed in and ends the session.
class HomeController extends ChangeNotifier {
  HomeController(this._auth) {
    _auth.addListener(notifyListeners);
  }

  final AuthController _auth;

  String get greeting {
    final name = _auth.user?.name;
    return name == null ? 'Hola' : 'Hola, $name';
  }

  String? get email => _auth.user?.email;

  Future<void> logout() => _auth.logout();

  @override
  void dispose() {
    _auth.removeListener(notifyListeners);
    super.dispose();
  }
}
