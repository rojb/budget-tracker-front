import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import 'payees_repository.dart';

/// Payees of the active plan while 15 and 41 are open.
class PayeesController extends ChangeNotifier {
  PayeesController(this._repository, this._plans);

  final PayeesRepository _repository;
  final PlansController _plans;

  List<PayeeData> _payees = const [];
  bool _loading = false;
  bool _failed = false;

  List<PayeeData> get payees => _payees;
  bool get loading => _loading;
  bool get failed => _failed;

  String get _planId => _plans.activePlan!.id;

  PayeeData? byId(String id) => _payees.where((p) => p.id == id).firstOrNull;

  Future<void> load() async {
    _loading = true;
    _failed = false;
    notifyListeners();
    try {
      _payees = await _repository.list(_planId);
    } on ApiFailure {
      _failed = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Throws [ApiFailure] (409 when the name is taken).
  Future<void> create(String name) async {
    final payee = await _repository.create(_planId, name);
    _payees = [..._payees, payee]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }

  /// Throws [ApiFailure] (409 when the name is taken).
  Future<void> rename(String payeeId, String name) async {
    final payee = await _repository.rename(_planId, payeeId, name);
    _payees = [for (final p in _payees) p.id == payeeId ? payee : p]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }

  /// Throws [ApiFailure].
  Future<void> delete(String payeeId) async {
    await _repository.delete(_planId, payeeId);
    _payees = _payees.where((p) => p.id != payeeId).toList();
    notifyListeners();
  }
}
