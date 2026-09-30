import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import 'accounts_controller.dart';
import 'accounts_repository.dart';

enum AccountFormOutcome { saved, invalid, forbidden, connectionProblem }

/// Form state of 28 Nueva cuenta (no [account]) and 42 Editar cuenta.
class AccountFormController extends ChangeNotifier {
  AccountFormController(this._accounts, {AccountData? account})
    : _accountId = account?.id,
      name = account?.name ?? '',
      kind = account?.kind ?? AccountKind.bank,
      openingBalanceMinor = account?.openingBalanceMinor ?? 0;

  final AccountsController _accounts;
  final String? _accountId;

  String name;
  AccountKind kind;
  int openingBalanceMinor;

  bool _saving = false;
  String? _nameError;
  String? _formError;

  bool get editing => _accountId != null;
  bool get saving => _saving;
  String? get nameError => _nameError;
  String? get formError => _formError;

  void setName(String value) => _set(() => name = value);
  void setKind(AccountKind value) => _set(() => kind = value);
  void setOpeningBalance(int value) => _set(() => openingBalanceMinor = value);

  void _set(VoidCallback change) {
    change();
    _nameError = null;
    _formError = null;
    notifyListeners();
  }

  Future<AccountFormOutcome> submit() async {
    if (_saving) return AccountFormOutcome.invalid;
    if (name.trim().isEmpty) {
      _nameError = 'Poné un nombre para la cuenta.';
      notifyListeners();
      return AccountFormOutcome.invalid;
    }
    _saving = true;
    notifyListeners();
    try {
      if (editing) {
        await _accounts.update(
          _accountId!,
          name: name.trim(),
          kind: kind,
          openingBalanceMinor: openingBalanceMinor,
        );
      } else {
        await _accounts.create(
          name: name.trim(),
          kind: kind,
          openingBalanceMinor: openingBalanceMinor,
        );
      }
      return AccountFormOutcome.saved;
    } on ApiFailure catch (failure) {
      switch (failure.kind) {
        case ApiFailureKind.validation:
          _nameError = failure.fieldErrors['name'];
          _formError = _nameError == null && failure.formErrors.isNotEmpty
              ? failure.formErrors.first
              : null;
          return AccountFormOutcome.invalid;
        case ApiFailureKind.forbidden:
          return AccountFormOutcome.forbidden;
        default:
          return AccountFormOutcome.connectionProblem;
      }
    } finally {
      _saving = false;
      notifyListeners();
    }
  }
}
