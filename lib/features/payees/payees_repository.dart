import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

class PayeeData {
  const PayeeData({
    required this.id,
    required this.name,
    required this.transactionCount,
    this.suggestedEnvelopeId,
  });

  final String id;
  final String name;
  final int transactionCount;
  final String? suggestedEnvelopeId;

  String get initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, trimmed.length < 2 ? 1 : 2).toUpperCase();
  }

  String get movementsLabel =>
      '$transactionCount ${transactionCount == 1 ? 'movimiento' : 'movimientos'}';

  static PayeeData fromApi(api.Payee payee) => PayeeData(
    id: payee.id,
    name: payee.name,
    transactionCount: payee.transactionCount,
    suggestedEnvelopeId: payee.suggestedEnvelopeId,
  );
}

/// Wraps the generated `PayeesApi`; every error surfaces as [ApiFailure].
class PayeesRepository {
  PayeesRepository(this._gateway);

  final ApiGateway _gateway;

  api.PayeesApi get _payees => _gateway.client.getPayeesApi();

  /// First 100 active payees by name (15 filters them in place).
  Future<List<PayeeData>> list(String planId) => guardApi(() async {
    final response = await _payees.listPayees(planId: planId, pageSize: 100);
    return response.data!.items.map(PayeeData.fromApi).toList();
  });

  Future<PayeeData> create(String planId, String name) => guardApi(() async {
    final response = await _payees.createPayee(
      planId: planId,
      createPayeeRequest: api.CreatePayeeRequest((b) => b..name = name),
    );
    return PayeeData.fromApi(response.data!);
  });

  Future<PayeeData> rename(String planId, String payeeId, String name) =>
      guardApi(() async {
        final response = await _payees.updatePayee(
          planId: planId,
          payeeId: payeeId,
          updatePayeeRequest: api.UpdatePayeeRequest((b) => b..name = name),
        );
        return PayeeData.fromApi(response.data!);
      });

  Future<void> delete(String planId, String payeeId) => guardApi(() async {
    await _payees.deletePayee(planId: planId, payeeId: payeeId);
  });
}
