import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import '../plans/plans_repository.dart';
import 'sharing_repository.dart';

enum JoinOutcome { joined, rejected, connectionProblem }

/// Joins a plan by code (30 and 45) and makes it the active plan.
class JoinController extends ChangeNotifier {
  JoinController(this._repository, this._plans);

  static const String invalidCode =
      'Código vencido o inválido. Pedile uno nuevo.';

  final SharingRepository _repository;
  final PlansController _plans;

  bool _loading = false;
  String? _error;
  PlanData? _joined;
  bool _disposed = false;

  bool get loading => _loading;
  String? get error => _error;
  PlanData? get joined => _joined;

  void clearError() {
    if (_error == null) return;
    _error = null;
    notifyListeners();
  }

  Future<JoinOutcome> join(String rawCode) async {
    if (_loading) return JoinOutcome.rejected;
    final code = rawCode.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
    if (!RegExp(r'^[A-Z0-9]{6}$').hasMatch(code)) {
      _error = invalidCode;
      notifyListeners();
      return JoinOutcome.rejected;
    }
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final plan = await _repository.accept(code);
      await _plans.load();
      await _plans.select(plan.id);
      _joined = plan;
      return JoinOutcome.joined;
    } on ApiFailure catch (failure) {
      switch (failure.kind) {
        case ApiFailureKind.notFound:
        case ApiFailureKind.validation:
          _error = invalidCode;
          return JoinOutcome.rejected;
        case ApiFailureKind.conflict:
          _error = 'Ya sos parte de ese plan, o ya tiene 5 miembros.';
          return JoinOutcome.rejected;
        default:
          return JoinOutcome.connectionProblem;
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
