import 'package:flutter/foundation.dart';

import '../auth/auth_controller.dart';
import '../envelopes/envelopes_controller.dart';
import '../envelopes/envelopes_repository.dart';
import '../plans/plans_controller.dart';

/// UI state of 01 Inicio: who is signed in, which plan is active and the goals
/// of the plan (the envelopes with a goal that has a date, from the API). The
/// month summary and Reportes arrive with later changes.
class HomeController extends ChangeNotifier {
  HomeController(this._auth, this._plans, this._envelopes) {
    _auth.addListener(notifyListeners);
    _plans.addListener(notifyListeners);
    _envelopes.addListener(notifyListeners);
  }

  final AuthController _auth;
  final PlansController _plans;
  final EnvelopesController _envelopes;

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

  /// The goals ("Metas") in the order of the envelope list.
  List<EnvelopeLineData> get goals => _envelopes.goalLines;

  /// True until the first load of the plan's envelopes finishes.
  bool get loadingGoals => !_envelopes.loaded && !_envelopes.failed;
  bool get goalsFailed => _envelopes.failed && !_envelopes.loaded;

  void retryGoals() => _envelopes.load();

  /// Id of the group "Metas" (compared without letter case), when the plan has
  /// one: "+ Nueva meta" preselects it.
  String? get goalsGroupId => _envelopes.groups
      .where((group) => group.name.toLowerCase() == 'metas')
      .firstOrNull
      ?.id;

  @override
  void dispose() {
    _auth.removeListener(notifyListeners);
    _plans.removeListener(notifyListeners);
    _envelopes.removeListener(notifyListeners);
    super.dispose();
  }
}
