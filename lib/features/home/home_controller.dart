import 'package:flutter/foundation.dart';

import '../auth/auth_controller.dart';
import '../plans/plans_controller.dart';

/// UI state of the 01 Inicio shell: who is signed in and which plan is active.
/// Goals and the month summary arrive with later changes.
class HomeController extends ChangeNotifier {
  HomeController(this._auth, this._plans) {
    _auth.addListener(notifyListeners);
    _plans.addListener(notifyListeners);
  }

  final AuthController _auth;
  final PlansController _plans;

  String get greeting {
    final name = _auth.user?.name.split(' ').first;
    return name == null ? 'Hola' : 'Hola, $name';
  }

  String get initials {
    final name = _auth.user?.name.trim() ?? '';
    if (name.isEmpty) return '?';
    return name.substring(0, name.length < 2 ? 1 : 2).toUpperCase();
  }

  String? get planName => _plans.activePlan?.name;

  @override
  void dispose() {
    _auth.removeListener(notifyListeners);
    _plans.removeListener(notifyListeners);
    super.dispose();
  }
}
