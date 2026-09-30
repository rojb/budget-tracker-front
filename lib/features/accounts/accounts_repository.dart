import 'package:flutter/widgets.dart' show IconData;
import 'package:api_client/api_client.dart' as api;
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

enum AccountKind {
  bank('Banco', UiIcons.landmark),
  digitalWallet('Billetera virtual', UiIcons.smartphone),
  cash('Efectivo', UiIcons.banknote);

  const AccountKind(this.label, this.icon);

  final String label;
  final IconData icon;

  api.AccountType get apiType => switch (this) {
    AccountKind.bank => api.AccountType.bank,
    AccountKind.digitalWallet => api.AccountType.digitalWallet,
    AccountKind.cash => api.AccountType.cash,
  };

  static AccountKind of(api.AccountType type) => switch (type) {
    api.AccountType.digitalWallet => AccountKind.digitalWallet,
    api.AccountType.cash => AccountKind.cash,
    _ => AccountKind.bank,
  };
}

class AccountData {
  const AccountData({
    required this.id,
    required this.name,
    required this.kind,
    required this.openingBalanceMinor,
    required this.balanceMinor,
    required this.archivedAt,
  });

  final String id;
  final String name;
  final AccountKind kind;
  final int openingBalanceMinor;

  /// Derived by the API (opening balance plus transactions).
  final int balanceMinor;
  final DateTime? archivedAt;

  bool get archived => archivedAt != null;

  static AccountData fromApi(api.Account account) => AccountData(
    id: account.id,
    name: account.name,
    kind: AccountKind.of(account.type),
    openingBalanceMinor: account.openingBalanceMinor,
    balanceMinor: account.balanceMinor,
    archivedAt: account.archivedAt,
  );
}

/// Account plus the money that entered and left it in [month] (screen 14).
class AccountDetailData {
  const AccountDetailData({
    required this.account,
    required this.month,
    required this.inflowMinor,
    required this.outflowMinor,
  });

  final AccountData account;
  final String month;
  final int inflowMinor;
  final int outflowMinor;
}

/// Wraps the generated `AccountsApi`; every error surfaces as [ApiFailure].
class AccountsRepository {
  AccountsRepository(this._gateway);

  final ApiGateway _gateway;

  api.AccountsApi get _accounts => _gateway.client.getAccountsApi();

  Future<List<AccountData>> list(String planId, {bool archived = false}) =>
      guardApi(() async {
        final response = await _accounts.listAccounts(
          planId: planId,
          archived: archived,
        );
        return (response.data ?? const <api.Account>[])
            .map(AccountData.fromApi)
            .toList();
      });

  Future<AccountData> create(
    String planId, {
    required String name,
    required AccountKind kind,
    required int openingBalanceMinor,
  }) => guardApi(() async {
    final response = await _accounts.createAccount(
      planId: planId,
      createAccountRequest: api.CreateAccountRequest(
        (b) => b
          ..name = name
          ..type = kind.apiType
          ..openingBalanceMinor = openingBalanceMinor,
      ),
    );
    return AccountData.fromApi(response.data!);
  });

  Future<AccountDetailData> detail(String planId, String accountId) =>
      guardApi(() async {
        final response = await _accounts.getAccount(
          planId: planId,
          accountId: accountId,
        );
        final detail = response.data!;
        return AccountDetailData(
          account: AccountData(
            id: detail.id,
            name: detail.name,
            kind: AccountKind.of(detail.type),
            openingBalanceMinor: detail.openingBalanceMinor,
            balanceMinor: detail.balanceMinor,
            archivedAt: detail.archivedAt,
          ),
          month: detail.month,
          inflowMinor: detail.inflowMinor,
          outflowMinor: detail.outflowMinor,
        );
      });

  Future<AccountData> update(
    String planId,
    String accountId, {
    required String name,
    required AccountKind kind,
    required int openingBalanceMinor,
  }) => guardApi(() async {
    final response = await _accounts.updateAccount(
      planId: planId,
      accountId: accountId,
      updateAccountRequest: api.UpdateAccountRequest(
        (b) => b
          ..name = name
          ..type = kind.apiType
          ..openingBalanceMinor = openingBalanceMinor,
      ),
    );
    return AccountData.fromApi(response.data!);
  });

  Future<AccountData> archive(String planId, String accountId) =>
      guardApi(() async {
        final response = await _accounts.archiveAccount(
          planId: planId,
          accountId: accountId,
        );
        return AccountData.fromApi(response.data!);
      });

  Future<AccountData> restore(String planId, String accountId) =>
      guardApi(() async {
        final response = await _accounts.restoreAccount(
          planId: planId,
          accountId: accountId,
        );
        return AccountData.fromApi(response.data!);
      });
}
