import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

class TransferData {
  const TransferData({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amountMinor,
    required this.occurredAt,
  });

  final String id;
  final String fromAccountId;
  final String toAccountId;
  final int amountMinor;
  final DateTime occurredAt;
}

/// Wraps the generated transfer operations; every error surfaces as [ApiFailure].
class TransfersRepository {
  TransfersRepository(this._gateway);

  final ApiGateway _gateway;

  api.AccountsApi get _accounts => _gateway.client.getAccountsApi();

  /// The latest 100 transfers that leave or enter [accountId].
  Future<List<TransferData>> forAccount(String planId, String accountId) =>
      guardApi(() async {
        final response = await _accounts.listTransfers(
          planId: planId,
          accountId: accountId,
          pageSize: 100,
        );
        return response.data!.items.map(_toData).toList();
      });

  Future<TransferData> create(
    String planId, {
    required String fromAccountId,
    required String toAccountId,
    required int amountMinor,
    required DateTime occurredAt,
  }) => guardApi(() async {
    final response = await _accounts.createTransfer(
      planId: planId,
      createTransferRequest: api.CreateTransferRequest(
        (b) => b
          ..fromAccountId = fromAccountId
          ..toAccountId = toAccountId
          ..amountMinor = amountMinor
          ..occurredAt = occurredAt.toUtc(),
      ),
    );
    return _toData(response.data!);
  });

  Future<void> delete(String planId, String transferId) => guardApi(
    () => _accounts.deleteTransfer(planId: planId, transferId: transferId),
  );

  static TransferData _toData(api.Transfer transfer) => TransferData(
    id: transfer.id,
    fromAccountId: transfer.fromAccountId,
    toAccountId: transfer.toAccountId,
    amountMinor: transfer.amountMinor,
    occurredAt: transfer.occurredAt,
  );
}
