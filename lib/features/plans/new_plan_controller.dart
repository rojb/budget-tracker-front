import 'package:flutter/foundation.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../accounts/accounts_repository.dart';
import 'plans_controller.dart';
import 'plans_repository.dart';

enum NewPlanOutcome { created, invalid, forbidden, connectionProblem }

/// Form state of screen 20 Nuevo plan (defaults of canonical state A).
class NewPlanController extends ChangeNotifier {
  NewPlanController(this._plans);

  final PlansController _plans;

  String name = 'Mi plan';
  Currency currency = Currency.ars;
  String accountName = 'Banco Nación';
  int openingBalanceMinor = 0;

  bool _saving = false;
  String? _error;

  bool get saving => _saving;

  /// Message shown under the form when it cannot be submitted.
  String? get error => _error;

  void setName(String value) => _set(() => name = value);
  void setCurrency(Currency value) => _set(() => currency = value);
  void setAccountName(String value) => _set(() => accountName = value);
  void setOpeningBalance(int value) => _set(() => openingBalanceMinor = value);

  void _set(VoidCallback change) {
    change();
    _error = null;
    notifyListeners();
  }

  Future<NewPlanOutcome> submit() async {
    if (_saving) return NewPlanOutcome.invalid;
    if (name.trim().isEmpty) {
      _error = 'Poné un nombre para el plan.';
    } else if (accountName.trim().isEmpty) {
      _error = 'Poné un nombre para la primera cuenta.';
    }
    if (_error != null) {
      notifyListeners();
      return NewPlanOutcome.invalid;
    }
    _saving = true;
    notifyListeners();
    try {
      await _plans.create(
        name: name.trim(),
        currency: currency,
        firstAccount: NewAccountData(
          name: accountName.trim(),
          type: AccountKind.bank.apiType,
          openingBalanceMinor: openingBalanceMinor,
        ),
      );
      return NewPlanOutcome.created;
    } on ApiFailure catch (failure) {
      switch (failure.kind) {
        case ApiFailureKind.validation:
          _error = failure.formErrors.isEmpty
              ? 'Revisá los datos del plan.'
              : failure.formErrors.first;
          return NewPlanOutcome.invalid;
        case ApiFailureKind.forbidden:
          return NewPlanOutcome.forbidden;
        default:
          return NewPlanOutcome.connectionProblem;
      }
    } finally {
      _saving = false;
      notifyListeners();
    }
  }
}
