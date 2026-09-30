import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import 'accounts_repository.dart';

/// Accounts of the active plan, shared by 06, 13, 14, 51 and the 37 picker.
/// Reloads when the active plan changes; mutations update it in place.
class AccountsController extends ChangeNotifier {
  AccountsController(this._repository, this._plans) {
    _plans.addListener(_onPlan);
    _onPlan();
  }

  final AccountsRepository _repository;
  final PlansController _plans;

  String? _planId;
  bool _loading = false;
  bool _failed = false;
  List<AccountData> _active = const [];
  List<AccountData> _archived = const [];

  bool get loading => _loading;
  bool get failed => _failed;
  List<AccountData> get active => _active;
  List<AccountData> get archived => _archived;

  /// Σ balances of active accounts (archived ones do not count, FR-03).
  int get totalMinor => _active.fold(0, (sum, a) => sum + a.balanceMinor);

  /// Share of [account] in the total, 0..1 (0 when the total is not positive).
  double shareOf(AccountData account) {
    final total = totalMinor;
    if (total <= 0 || account.balanceMinor <= 0) return 0;
    return account.balanceMinor / total;
  }

  void _onPlan() {
    final planId = _plans.activePlan?.id;
    if (planId == _planId) return;
    _planId = planId;
    _active = const [];
    _archived = const [];
    if (planId == null) {
      notifyListeners();
      return;
    }
    load();
  }

  Future<void> load() async {
    final planId = _planId;
    if (planId == null) return;
    _loading = true;
    _failed = false;
    notifyListeners();
    try {
      final results = await Future.wait([
        _repository.list(planId),
        _repository.list(planId, archived: true),
      ]);
      if (planId != _planId) return;
      _active = results[0];
      _archived = results[1];
    } on ApiFailure {
      _failed = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  AccountData? byId(String id) =>
      [..._active, ..._archived].where((a) => a.id == id).firstOrNull;

  /// Throws [ApiFailure].
  Future<AccountData> create({
    required String name,
    required AccountKind kind,
    required int openingBalanceMinor,
  }) async {
    final account = await _repository.create(
      _planId!,
      name: name,
      kind: kind,
      openingBalanceMinor: openingBalanceMinor,
    );
    _active = [..._active, account];
    notifyListeners();
    return account;
  }

  /// Throws [ApiFailure].
  Future<AccountData> update(
    String accountId, {
    required String name,
    required AccountKind kind,
    required int openingBalanceMinor,
  }) async {
    final account = await _repository.update(
      _planId!,
      accountId,
      name: name,
      kind: kind,
      openingBalanceMinor: openingBalanceMinor,
    );
    _active = [for (final a in _active) a.id == accountId ? account : a];
    notifyListeners();
    return account;
  }

  /// Throws [ApiFailure].
  Future<void> archive(String accountId) async {
    final account = await _repository.archive(_planId!, accountId);
    _active = _active.where((a) => a.id != accountId).toList();
    _archived = [account, ..._archived];
    notifyListeners();
  }

  /// Throws [ApiFailure].
  Future<void> restore(String accountId) async {
    await _repository.restore(_planId!, accountId);
    // Reload so the restored account takes its creation-order place.
    await load();
  }

  Future<AccountDetailData> detail(String accountId) =>
      _repository.detail(_planId!, accountId);

  @override
  void dispose() {
    _plans.removeListener(_onPlan);
    super.dispose();
  }
}
