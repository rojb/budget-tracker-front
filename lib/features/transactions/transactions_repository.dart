import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

/// One portion of a transaction. [envelopeId] is null for an income sent to
/// Ready to Assign and for a portion whose envelope was deleted ("Sin sobre").
class TransactionSplitData {
  const TransactionSplitData({
    required this.amountMinor,
    this.envelopeId,
    this.envelopeName,
  });

  final String? envelopeId;
  final String? envelopeName;
  final int amountMinor;
}

class TransactionData {
  const TransactionData({
    required this.id,
    required this.isExpense,
    required this.accountId,
    required this.accountName,
    required this.amountMinor,
    required this.occurredAt,
    required this.splits,
    this.payeeId,
    this.payeeName,
    this.description,
  });

  final String id;
  final bool isExpense;
  final String accountId;
  final String accountName;

  /// Positive; [isExpense] gives the sign.
  final int amountMinor;
  final DateTime occurredAt;
  final String? payeeId;
  final String? payeeName;
  final String? description;
  final List<TransactionSplitData> splits;

  static TransactionData fromApi(api.Transaction transaction) =>
      TransactionData(
        id: transaction.id,
        isExpense: transaction.direction == api.TransactionDirection.expense,
        accountId: transaction.accountId,
        accountName: transaction.accountName,
        amountMinor: transaction.amountMinor,
        occurredAt: transaction.occurredAt,
        payeeId: transaction.payeeId,
        payeeName: transaction.payeeName,
        description: transaction.description,
        splits: [
          for (final split in transaction.splits)
            TransactionSplitData(
              envelopeId: split.envelopeId,
              envelopeName: split.envelopeName,
              amountMinor: split.amountMinor,
            ),
        ],
      );
}

class TransactionPageData {
  const TransactionPageData({
    required this.items,
    required this.page,
    required this.total,
  });

  final List<TransactionData> items;
  final int page;
  final int total;
}

/// What the user typed in 07 / 08 / 09, ready to send. An expense carries
/// [envelopeId] or [splits]; an income [envelopeId] or nothing (Ready to
/// Assign). The payee is an existing one ([payeeId]) or a typed name.
class NewTransaction {
  const NewTransaction({
    required this.isExpense,
    required this.accountId,
    required this.amountMinor,
    required this.occurredAt,
    this.payeeId,
    this.payeeName,
    this.description,
    this.envelopeId,
    this.splits = const [],
  });

  final bool isExpense;
  final String accountId;
  final int amountMinor;
  final DateTime occurredAt;
  final String? payeeId;
  final String? payeeName;
  final String? description;
  final String? envelopeId;

  /// Envelope id and amount of each portion of a split expense.
  final List<({String envelopeId, int amountMinor})> splits;
}

/// Wraps the generated `TransactionsApi`; every error surfaces as [ApiFailure].
class TransactionsRepository {
  TransactionsRepository(this._gateway);

  final ApiGateway _gateway;

  api.TransactionsApi get _api => _gateway.client.getTransactionsApi();

  Future<TransactionPageData> list(
    String planId, {
    String? accountId,
    int page = 1,
    int pageSize = 30,
  }) => guardApi(() async {
    final response = await _api.listTransactions(
      planId: planId,
      accountId: accountId,
      page: page,
      pageSize: pageSize,
    );
    final data = response.data!;
    return TransactionPageData(
      items: data.items.map(TransactionData.fromApi).toList(),
      page: data.page,
      total: data.total,
    );
  });

  Future<TransactionData> create(String planId, NewTransaction draft) =>
      guardApi(() async {
        final response = await _api.createTransaction(
          planId: planId,
          createTransactionRequest: api.CreateTransactionRequest((b) {
            b
              ..direction = draft.isExpense
                  ? api.TransactionDirection.expense
                  : api.TransactionDirection.income
              ..accountId = draft.accountId
              ..amountMinor = draft.amountMinor
              ..occurredAt = draft.occurredAt.toUtc()
              ..payeeId = draft.payeeId
              ..payeeName = draft.payeeName
              ..description = draft.description
              ..envelopeId = draft.envelopeId;
            if (draft.splits.isNotEmpty) {
              b.splits.replace([
                for (final split in draft.splits)
                  api.CreateTransactionSplit(
                    (s) => s
                      ..envelopeId = split.envelopeId
                      ..amountMinor = split.amountMinor,
                  ),
              ]);
            }
          }),
        );
        return TransactionData.fromApi(response.data!);
      });
}
