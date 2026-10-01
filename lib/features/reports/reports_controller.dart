import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plan/month_keys.dart';
import '../plans/plans_controller.dart';
import 'reports_repository.dart';

/// The tabs of 17: what the figure, the bars and the card show.
enum ReportTab { spending, income, netWorth }

/// State of one visit to 17 Reportes: the range (the last [rangeMonths]
/// months, ending in the current one), the tab and the selected month. The
/// three reports load together; changing the tab or the month only changes
/// what is drawn.
class ReportsController extends ChangeNotifier {
  ReportsController(this._repository, this._plans, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final ReportsRepository _repository;
  final PlansController _plans;
  final DateTime Function() _now;

  int _rangeMonths = 6;
  ReportTab _tab = ReportTab.spending;
  List<ReportMonthData> _months = const [];
  int _selected = 0;
  bool _loading = false;
  bool _failed = false;

  int get rangeMonths => _rangeMonths;
  ReportTab get tab => _tab;
  List<ReportMonthData> get months => _months;
  int get selectedIndex => _selected;
  bool get loading => _loading;
  bool get failed => _failed;

  ReportMonthData? get selected => _months.isEmpty ? null : _months[_selected];

  /// The month before the selected one, when the range has it.
  ReportMonthData? get previous =>
      _selected > 0 ? _months[_selected - 1] : null;

  void setTab(ReportTab tab) {
    if (tab == _tab) return;
    _tab = tab;
    notifyListeners();
  }

  void select(int index) {
    if (index == _selected || index < 0 || index >= _months.length) return;
    _selected = index;
    notifyListeners();
  }

  /// Loads the last [months] months and selects the current one.
  Future<void> setRange(int months) {
    _rangeMonths = months;
    return load();
  }

  Future<void> load() async {
    final planId = _plans.activePlan?.id;
    if (planId == null) return;
    final to = monthKeyOf(_now());
    _loading = true;
    _failed = false;
    notifyListeners();
    try {
      _months = await _repository.months(
        planId,
        from: shiftMonth(to, -(_rangeMonths - 1)),
        to: to,
      );
      _selected = _months.isEmpty ? 0 : _months.length - 1;
    } on ApiFailure {
      _failed = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
