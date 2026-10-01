import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import 'transaction_filter.dart';
import 'transactions_repository.dart';

/// Movements of the active plan, shared by 10 and the save flow of 07 / 08 / 09.
/// It holds the pages loaded so far (newest first), reloads when the active
/// plan changes and starts over after every recorded transaction. It also holds
/// the active filter of 10 (11 and the search) and the summary the API returns
/// for it.
class TransactionsController extends ChangeNotifier {
  TransactionsController(this._repository, this._plans) {
    _plans.addListener(_onPlan);
    _onPlan();
  }

  static const int pageSize = 30;

  final TransactionsRepository _repository;
  final PlansController _plans;

  String? _planId;
  bool _loading = false;
  bool _loadingMore = false;
  bool _loaded = false;
  bool _failed = false;
  int _page = 0;
  int _total = 0;
  int _outflow = 0;
  int _inflow = 0;
  TransactionFilter _filter = TransactionFilter.none;
  List<TransactionData> _items = const [];

  /// True while the first page loads.
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;

  /// True once the first page of the active plan arrived.
  bool get loaded => _loaded;
  bool get failed => _failed;
  List<TransactionData> get items => _items;
  int get total => _total;

  /// What the active filter selects: the money that left and that came in.
  int get outflowMinor => _outflow;
  int get inflowMinor => _inflow;
  TransactionFilter get filter => _filter;
  bool get hasMore => _items.length < _total;

  void _onPlan() {
    final planId = _plans.activePlan?.id;
    if (planId == _planId) return;
    _planId = planId;
    _items = const [];
    _page = 0;
    _total = 0;
    _outflow = 0;
    _inflow = 0;
    _filter = TransactionFilter.none;
    _loaded = false;
    _failed = false;
    if (planId == null) {
      notifyListeners();
      return;
    }
    refresh();
  }

  /// Reloads the first page (pull to refresh, after a save).
  Future<void> refresh() async {
    final planId = _planId;
    if (planId == null) return;
    _loading = true;
    _failed = false;
    notifyListeners();
    try {
      final filter = _filter;
      final page = await _repository.list(
        planId,
        filter: filter,
        pageSize: pageSize,
      );
      // A newer filter or plan superseded this answer.
      if (planId != _planId || filter != _filter) return;
      _items = page.items;
      _page = 1;
      _total = page.total;
      _outflow = page.outflowMinor;
      _inflow = page.inflowMinor;
      _loaded = true;
    } on ApiFailure {
      if (planId == _planId) _failed = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Appends the next page; ignores rows it already has (a save in between
  /// shifts the pages by one).
  Future<void> loadMore() async {
    final planId = _planId;
    if (planId == null || _loading || _loadingMore || !hasMore) return;
    _loadingMore = true;
    notifyListeners();
    try {
      final filter = _filter;
      final page = await _repository.list(
        planId,
        filter: filter,
        page: _page + 1,
        pageSize: pageSize,
      );
      if (planId != _planId || filter != _filter) return;
      final known = {for (final item in _items) item.id};
      _items = [
        ..._items,
        ...page.items.where((item) => !known.contains(item.id)),
      ];
      _page += 1;
      _total = page.total;
    } on ApiFailure {
      // The rows already shown stay; scrolling again retries.
    } finally {
      _loadingMore = false;
      notifyListeners();
    }
  }

  /// Applies a filter (or a new search text) and reloads from the first page.
  Future<void> setFilter(TransactionFilter filter) {
    if (filter == _filter) return Future.value();
    _filter = filter;
    _items = const [];
    _page = 0;
    _total = 0;
    _loaded = false;
    return refresh();
  }

  /// How many movements [filter] selects (the "Ver N movimientos" of 11).
  Future<int> count(TransactionFilter filter) async {
    final page = await _repository.list(_planId!, filter: filter, pageSize: 1);
    return page.total;
  }

  /// Throws [ApiFailure]. Reloads the list on success; the caller refreshes
  /// the envelopes and accounts, whose figures change.
  Future<TransactionData> create(NewTransaction draft) async {
    final created = await _repository.create(_planId!, draft);
    await refresh();
    return created;
  }

  /// Replaces the state of a transaction (an edit, or the undo of one). Throws
  /// [ApiFailure]; reloads the list on success like [create].
  Future<TransactionChangeData> update(String id, NewTransaction state) async {
    final change = await _repository.update(_planId!, id, state);
    await refresh();
    return change;
  }

  /// Logical delete; returns the months recalculated. Throws [ApiFailure].
  Future<List<String>> remove(String id) async {
    final months = await _repository.delete(_planId!, id);
    await refresh();
    return months;
  }

  /// Undo of [remove]: the same transaction comes back. Throws [ApiFailure].
  Future<TransactionChangeData> restore(String id) async {
    final change = await _repository.restore(_planId!, id);
    await refresh();
    return change;
  }

  /// The latest movements of one account (14 merges them with its transfers).
  Future<List<TransactionData>> forAccount(String accountId) async {
    final page = await _repository.list(
      _planId!,
      accountId: accountId,
      pageSize: 100,
    );
    return page.items;
  }

  @override
  void dispose() {
    _plans.removeListener(_onPlan);
    super.dispose();
  }
}
