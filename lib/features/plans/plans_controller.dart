import 'package:flutter/foundation.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../../core/plan/active_plan_storage.dart';
import '../auth/auth_controller.dart';
import 'plans_repository.dart';

enum PlansStatus {
  /// Signed out, or signed in and the list is still loading.
  idle,
  loading,
  ready,

  /// The list could not be loaded; [PlansController.load] retries.
  failed,
}

/// App-scoped plan state: the user's plans and the active one. Loads when the
/// session starts and clears when it ends. The router and every plan-scoped
/// screen listen to it.
class PlansController extends ChangeNotifier {
  PlansController(this._repository, this._storage, this._auth) {
    _auth.addListener(_onSession);
    _onSession();
  }

  final PlansRepository _repository;
  final ActivePlanStorage _storage;
  final AuthController _auth;

  PlansStatus _status = PlansStatus.idle;
  List<PlanData> _plans = const [];
  PlanData? _active;
  SessionStatus? _lastSession;

  PlansStatus get status => _status;
  List<PlanData> get plans => _plans;
  PlanData? get activePlan => _active;
  bool get hasPlans => _plans.isNotEmpty;

  /// Currency of the active plan (pesos until one is loaded).
  Currency get currency => _active?.currency ?? Currency.ars;

  void _onSession() {
    final session = _auth.status;
    if (session == _lastSession) return;
    _lastSession = session;
    if (session == SessionStatus.signedIn) {
      load();
    } else {
      _plans = const [];
      _active = null;
      _status = PlansStatus.idle;
      notifyListeners();
    }
  }

  /// Loads the plans and picks the remembered active plan, or the first one.
  /// A reload while ready keeps the status, so the router does not bounce to
  /// the splash (e.g. after joining a plan).
  Future<void> load() async {
    if (_status != PlansStatus.ready) {
      _status = PlansStatus.loading;
      notifyListeners();
    }
    try {
      _plans = await _repository.list();
      final remembered = await _storage.read();
      _active =
          _plans.where((plan) => plan.id == remembered).firstOrNull ??
          _plans.firstOrNull;
      _status = PlansStatus.ready;
    } on ApiFailure {
      _status = PlansStatus.failed;
    }
    notifyListeners();
  }

  /// Reloads the plans in the background (members who joined or left, renamed
  /// plans). Unlike [load] it never changes the status, and a failure keeps the
  /// list that is already shown, so it can run while a screen is open.
  Future<void> refresh() async {
    if (_status != PlansStatus.ready) return;
    try {
      final plans = await _repository.list();
      // The session may have ended while the request was in flight.
      if (_status != PlansStatus.ready) return;
      _plans = plans;
      final remembered = _active?.id;
      _active =
          _plans.where((plan) => plan.id == remembered).firstOrNull ??
          _plans.firstOrNull;
      notifyListeners();
    } on ApiFailure {
      // Keep what is shown; the next refresh retries.
    }
  }

  Future<void> select(String planId) async {
    final plan = _plans.where((p) => p.id == planId).firstOrNull;
    if (plan == null) return;
    _active = plan;
    await _storage.write(plan.id);
    notifyListeners();
  }

  /// Creates a plan and makes it active. Throws [ApiFailure].
  Future<PlanData> create({
    required String name,
    required Currency currency,
    NewAccountData? firstAccount,
  }) async {
    final plan = await _repository.create(
      name: name,
      currency: currency,
      firstAccount: firstAccount,
    );
    _plans = [..._plans, plan];
    _active = plan;
    _status = PlansStatus.ready;
    await _storage.write(plan.id);
    notifyListeners();
    return plan;
  }

  @override
  void dispose() {
    _auth.removeListener(_onSession);
    super.dispose();
  }
}
