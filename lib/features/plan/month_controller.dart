import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../envelopes/envelopes_controller.dart';
import '../plans/plans_controller.dart';
import 'month_keys.dart';
import 'months_repository.dart';
import 'plan_filters.dart';

/// The monthly flow of the Plan tab (add-monthly-assignment): which month 02/04
/// shows (FR-15), its summary from the API (current month, future or not), the
/// status filter (FR-21), assigning money (03/53) and the month close (25).
/// The envelopes and Ready to Assign of the month stay in [EnvelopesController];
/// this controller follows it and reloads the summary after each of its loads.
class MonthController extends ChangeNotifier {
  MonthController(this._repository, this._plans, this._envelopes) {
    _envelopes.addListener(_onEnvelopes);
    _onEnvelopes();
  }

  final MonthsRepository _repository;
  final PlansController _plans;
  final EnvelopesController _envelopes;

  MonthSummaryData? _summary;
  StatusFilter _filter = StatusFilter.all;
  bool _wasLoading = false;
  int _token = 0;

  /// Closes already checked this session ("plan:month"), so a dismissed 25
  /// opens again only on the next visit.
  final Set<String> _closesChecked = {};

  /// Summary of the viewed month; null while it loads.
  MonthSummaryData? get summary =>
      _summary?.month == _envelopes.month ? _summary : null;

  /// Current month in the plan's time zone, once a summary arrived.
  String? get currentMonth => _summary?.currentMonth;

  /// Month the plan view shows ("2026-09").
  String? get viewedMonth => _envelopes.month;

  bool get isFuture {
    final current = currentMonth;
    final viewed = viewedMonth;
    return current != null && viewed != null && viewed.compareTo(current) > 0;
  }

  StatusFilter get filter => _filter;

  bool get canEdit => _plans.activePlan?.canEdit ?? false;

  void setFilter(StatusFilter filter) {
    if (filter == _filter) return;
    _filter = filter;
    notifyListeners();
  }

  void previous() => _move(-1);

  void next() => _move(1);

  /// Back to the current month (the "Hoy" of 04).
  Future<void> today() => _envelopes.showMonth(null);

  Future<void> showMonth(String month) => _envelopes.showMonth(month);

  void _move(int delta) {
    final month = viewedMonth;
    if (month == null) return;
    _envelopes.showMonth(shiftMonth(month, delta));
  }

  void _onEnvelopes() {
    final loading = _envelopes.loading;
    final finished = _wasLoading && !loading;
    _wasLoading = loading;
    if (_plans.activePlan == null) {
      _summary = null;
      _closesChecked.clear();
    }
    if (_envelopes.month == null) return;
    if (finished || _summary?.month != _envelopes.month) _loadSummary();
  }

  Future<void> _loadSummary() async {
    final planId = _plans.activePlan?.id;
    final month = _envelopes.month;
    if (planId == null || month == null) return;
    final token = ++_token;
    try {
      final summary = await _repository.summary(planId, month);
      if (token != _token) return;
      _summary = summary;
      notifyListeners();
    } on ApiFailure {
      // The plan view keeps working without it; the next load retries.
    }
  }

  /// Adds [amountMinor] to the envelope's assignment of [month] and reloads the
  /// plan view. Throws [ApiFailure].
  Future<AssignResultData> assign({
    required String month,
    required String envelopeId,
    required int amountMinor,
  }) async {
    final result = await _repository.assign(
      _plans.activePlan!.id,
      month,
      envelopeId: envelopeId,
      amountMinor: amountMinor,
    );
    await _envelopes.load();
    return result;
  }

  /// The close of the month before the current one when 25 has to open by
  /// itself: the current month is shown, the user can edit, the close moves
  /// money and was not confirmed. Asked once per plan and month per session.
  Future<MonthCloseData?> pendingClose() async {
    final plan = _plans.activePlan;
    final summary = this.summary;
    if (plan == null || !plan.canEdit || summary == null) return null;
    if (!summary.isCurrent) return null;
    final from = shiftMonth(summary.currentMonth, -1);
    final key = '${plan.id}:$from';
    if (!_closesChecked.add(key)) return null;
    try {
      final close = await _repository.close(plan.id, from);
      return !close.confirmed && close.hasMoney ? close : null;
    } on ApiFailure {
      _closesChecked.remove(key);
      return null;
    }
  }

  Future<MonthCloseData> close(String fromMonth) =>
      _repository.close(_plans.activePlan!.id, fromMonth);

  /// Confirms the close of [fromMonth] and shows the current month. Throws
  /// [ApiFailure].
  Future<void> confirmClose(String fromMonth) async {
    await _repository.confirmClose(_plans.activePlan!.id, fromMonth);
    await _envelopes.showMonth(null);
  }

  @override
  void dispose() {
    _envelopes.removeListener(_onEnvelopes);
    super.dispose();
  }
}
