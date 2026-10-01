import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';
import '../envelopes/envelopes_repository.dart';

/// The figures the API derives for one budget month (02/04).
class MonthSummaryData {
  const MonthSummaryData({
    required this.month,
    required this.currentMonth,
    required this.isFuture,
    required this.readyToAssignMinor,
    required this.assignedMinor,
    required this.envelopeCount,
  });

  /// "2026-09".
  final String month;

  /// Current month in the plan's time zone.
  final String currentMonth;
  final bool isFuture;
  final int readyToAssignMinor;
  final int assignedMinor;
  final int envelopeCount;

  bool get isCurrent => month == currentMonth;

  static MonthSummaryData fromApi(api.MonthSummary summary) => MonthSummaryData(
    month: summary.month,
    currentMonth: summary.currentMonth,
    isFuture: summary.isFuture,
    readyToAssignMinor: summary.readyToAssignMinor,
    assignedMinor: summary.assignedMinor,
    envelopeCount: summary.envelopeCount,
  );
}

/// An envelope of a month close and the money it carries or has deducted.
class CloseLineData {
  const CloseLineData({
    required this.envelopeId,
    required this.name,
    required this.amountMinor,
  });

  final String envelopeId;
  final String name;

  /// Always positive: what carries over, or what is deducted.
  final int amountMinor;

  static CloseLineData fromApi(api.CloseLine line) => CloseLineData(
    envelopeId: line.envelopeId,
    name: line.name,
    amountMinor: line.amountMinor,
  );
}

/// The close of [fromMonth] into [toMonth] (25). The balance, available and
/// reserved figures are [toMonth]'s, so balance − available − reserved =
/// [readyToAssignToMinor].
class MonthCloseData {
  const MonthCloseData({
    required this.fromMonth,
    required this.toMonth,
    required this.carried,
    required this.deducted,
    required this.readyToAssignToMinor,
    required this.balanceMinor,
    required this.availableMinor,
    required this.futureAssignedMinor,
    required this.confirmed,
  });

  final String fromMonth;
  final String toMonth;
  final List<CloseLineData> carried;
  final List<CloseLineData> deducted;
  final int readyToAssignToMinor;
  final int balanceMinor;
  final int availableMinor;
  final int futureAssignedMinor;
  final bool confirmed;

  /// True when closing the month moves any money (something to show in 25).
  bool get hasMoney => carried.isNotEmpty || deducted.isNotEmpty;

  static MonthCloseData fromApi(api.MonthClose close) => MonthCloseData(
    fromMonth: close.fromMonth,
    toMonth: close.toMonth,
    carried: close.carried.map(CloseLineData.fromApi).toList(),
    deducted: close.deducted.map(CloseLineData.fromApi).toList(),
    readyToAssignToMinor: close.readyToAssignToMinor,
    balanceMinor: close.balanceMinor,
    availableMinor: close.availableMinor,
    futureAssignedMinor: close.futureAssignedMinor,
    confirmed: close.confirmed,
  );
}

/// Result of assigning money (03/53): the envelope's new line and the month's
/// Ready to Assign.
class AssignResultData {
  const AssignResultData({
    required this.month,
    required this.readyToAssignMinor,
    required this.line,
  });

  final String month;
  final int readyToAssignMinor;
  final EnvelopeLineData line;
}

/// Wraps the generated `MonthsApi`; every error surfaces as [ApiFailure].
class MonthsRepository {
  MonthsRepository(this._gateway);

  final ApiGateway _gateway;

  api.MonthsApi get _api => _gateway.client.getMonthsApi();

  Future<MonthSummaryData> summary(String planId, String month) => guardApi(
    () async {
      final response = await _api.getMonthSummary(planId: planId, month: month);
      return MonthSummaryData.fromApi(response.data!);
    },
  );

  /// Adds [amountMinor] to the envelope's assignment of [month]. Throws
  /// [ApiFailure] (403 for a viewer).
  Future<AssignResultData> assign(
    String planId,
    String month, {
    required String envelopeId,
    required int amountMinor,
  }) => guardApi(() async {
    final response = await _api.assignToEnvelope(
      planId: planId,
      month: month,
      assignMoneyRequest: api.AssignMoneyRequest(
        (b) => b
          ..envelopeId = envelopeId
          ..amountMinor = amountMinor,
      ),
    );
    final result = response.data!;
    return AssignResultData(
      month: result.month,
      readyToAssignMinor: result.readyToAssignMinor,
      line: EnvelopeLineData.fromApi(result.line),
    );
  });

  Future<MonthCloseData> close(String planId, String month) =>
      guardApi(() async {
        final response = await _api.getMonthClose(planId: planId, month: month);
        return MonthCloseData.fromApi(response.data!);
      });

  /// Throws [ApiFailure] (409 when the month has not ended).
  Future<MonthCloseData> confirmClose(String planId, String month) =>
      guardApi(() async {
        final response = await _api.confirmMonthClose(
          planId: planId,
          month: month,
        );
        return MonthCloseData.fromApi(response.data!);
      });
}
