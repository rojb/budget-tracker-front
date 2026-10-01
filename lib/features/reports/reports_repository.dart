import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

/// One envelope's spending in a month.
class EnvelopeSpendingData {
  const EnvelopeSpendingData({
    required this.name,
    required this.icon,
    required this.amountMinor,
  });

  final String name;

  /// Name of the API's `EnvelopeIcon`.
  final String icon;
  final int amountMinor;
}

/// The three figures of one month of the reports (17).
class ReportMonthData {
  const ReportMonthData({
    required this.month,
    required this.spentMinor,
    required this.envelopes,
    required this.incomeMinor,
    required this.expenseMinor,
    required this.netWorthMinor,
  });

  /// "2026-09".
  final String month;
  final int spentMinor;

  /// Envelopes with spending, largest first.
  final List<EnvelopeSpendingData> envelopes;
  final int incomeMinor;
  final int expenseMinor;
  final int netWorthMinor;
}

/// Wraps the generated `ReportsApi`: the three reports of a range, joined by
/// month. Every error surfaces as [ApiFailure].
class ReportsRepository {
  ReportsRepository(this._gateway);

  final ApiGateway _gateway;

  api.ReportsApi get _api => _gateway.client.getReportsApi();

  /// The months from [from] to [to] ("2026-04".."2026-09"), oldest first.
  Future<List<ReportMonthData>> months(
    String planId, {
    required String from,
    required String to,
  }) => guardApi(() async {
    final results = await Future.wait([
      _api.getSpendingReport(planId: planId, from: from, to: to),
      _api.getIncomeExpenseReport(planId: planId, from: from, to: to),
      _api.getNetWorthReport(planId: planId, from: from, to: to),
    ]);
    final spending = (results[0].data as api.SpendingReport).months.toList();
    final flows = (results[1].data as api.IncomeExpenseReport).months.toList();
    final worth = (results[2].data as api.NetWorthReport).months.toList();
    return [
      for (var i = 0; i < spending.length; i++)
        ReportMonthData(
          month: spending[i].month,
          spentMinor: spending[i].totalMinor,
          envelopes: [
            for (final envelope in spending[i].envelopes)
              EnvelopeSpendingData(
                name: envelope.name,
                icon: envelope.icon.name,
                amountMinor: envelope.amountMinor,
              ),
          ],
          incomeMinor: flows[i].incomeMinor,
          expenseMinor: flows[i].expenseMinor,
          netWorthMinor: worth[i].balanceMinor,
        ),
    ];
  });
}
