import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';
import 'transaction_filter.dart';

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
    required this.createdAt,
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

  /// When it was registered: the lists are ordered and grouped by it.
  final DateTime createdAt;
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
        createdAt: transaction.createdAt,
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
    this.outflowMinor = 0,
    this.inflowMinor = 0,
  });

  final List<TransactionData> items;
  final int page;
  final int total;

  /// Money that left and that came in over every transaction the filter
  /// selects, not only this page.
  final int outflowMinor;
  final int inflowMinor;
}

/// Result of an edit or a restore: the transaction and the months whose
/// figures were recalculated ("2026-08", ...).
class TransactionChangeData {
  const TransactionChangeData({
    required this.transaction,
    required this.affectedMonths,
  });

  final TransactionData transaction;
  final List<String> affectedMonths;
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

  /// The state of [data] as an edit request: sending it back undoes an edit.
  /// Null when it cannot be expressed (an expense with a portion whose
  /// envelope was deleted needs an envelope).
  static NewTransaction? snapshotOf(TransactionData data) {
    final portions = data.splits;
    if (data.isExpense && portions.any((p) => p.envelopeId == null)) {
      return null;
    }
    return NewTransaction(
      isExpense: data.isExpense,
      accountId: data.accountId,
      amountMinor: data.amountMinor,
      occurredAt: data.occurredAt,
      payeeId: data.payeeId,
      description: data.description,
      envelopeId: portions.length == 1 ? portions.first.envelopeId : null,
      splits: portions.length > 1
          ? [
              for (final p in portions)
                (envelopeId: p.envelopeId!, amountMinor: p.amountMinor),
            ]
          : const [],
    );
  }
}

/// Wraps the generated TransactionsApi; every error surfaces as [ApiFailure].
class TransactionsRepository {
  TransactionsRepository(this._gateway);

  final ApiGateway _gateway;

  api.TransactionsApi get _api => _gateway.client.getTransactionsApi();

  Future<TransactionPageData> list(
    String planId, {
    String? accountId,
    TransactionFilter filter = TransactionFilter.none,
    int page = 1,
    int pageSize = 30,
  }) => guardApi(() async {
    final response = await _api.listTransactions(
      planId: planId,
      accountId: accountId ?? filter.accountId,
      payeeId: filter.payeeId,
      envelopeId: filter.envelopeId,
      direction: switch (filter.kind) {
        TransactionKind.all => null,
        TransactionKind.expense => api.TransactionDirection.expense,
        TransactionKind.income => api.TransactionDirection.income,
      },
      from: filter.from == null ? null : _apiDate(filter.from!),
      to: filter.to == null ? null : _apiDate(filter.to!),
      timeFrom: filter.timeFrom == null ? null : formatTime(filter.timeFrom!),
      timeTo: filter.timeTo == null ? null : formatTime(filter.timeTo!),
      q: filter.query.isEmpty ? null : filter.query,
      page: page,
      pageSize: pageSize,
    );
    final data = response.data!;
    return TransactionPageData(
      items: data.items.map(TransactionData.fromApi).toList(),
      page: data.page,
      total: data.total,
      outflowMinor: data.summary.outflowMinor,
      inflowMinor: data.summary.inflowMinor,
    );
  });

  Future<TransactionData> create(String planId, NewTransaction draft) =>
      guardApi(() async {
        final response = await _api.createTransaction(
          planId: planId,
          createTransactionRequest: _request(draft),
        );
        return TransactionData.fromApi(response.data!);
      });

  /// Replaces the editable state of a transaction (the same body as [create]).
  Future<TransactionChangeData> update(
    String planId,
    String transactionId,
    NewTransaction state,
  ) => guardApi(() async {
    final response = await _api.updateTransaction(
      planId: planId,
      transactionId: transactionId,
      createTransactionRequest: _request(state),
    );
    return _change(response.data!);
  });

  /// Logical delete; returns the months whose figures were recalculated.
  Future<List<String>> delete(String planId, String transactionId) =>
      guardApi(() async {
        final response = await _api.deleteTransaction(
          planId: planId,
          transactionId: transactionId,
        );
        return response.data!.affectedMonths.toList();
      });

  Future<TransactionChangeData> restore(String planId, String transactionId) =>
      guardApi(() async {
        final response = await _api.restoreTransaction(
          planId: planId,
          transactionId: transactionId,
        );
        return _change(response.data!);
      });

  static TransactionChangeData _change(api.TransactionChange change) =>
      TransactionChangeData(
        transaction: TransactionData.fromApi(change.transaction),
        affectedMonths: change.affectedMonths.toList(),
      );

  static api.Date _apiDate(DateTime date) =>
      api.Date(date.year, date.month, date.day);

  static api.CreateTransactionRequest _request(NewTransaction draft) =>
      api.CreateTransactionRequest((b) {
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
      });
}
