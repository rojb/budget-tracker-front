import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import 'transactions_repository.dart';

/// Movements of the active plan, shared by 10 and the save flow of 07 / 08 / 09.
/// It holds the pages loaded so far (newest first), reloads when the active
/// plan changes and starts over after every recorded transaction.
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
  List<TransactionData> _items = const [];

  /// True while the first page loads.
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;

  /// True once the first page of the active plan arrived.
  bool get loaded => _loaded;
  bool get failed => _failed;
  List<TransactionData> get items => _items;
  int get total => _total;
  bool get hasMore => _items.length < _total;

  void _onPlan() {
    final planId = _plans.activePlan?.id;
    if (planId == _planId) return;
    _planId = planId;
    _items = const [];
    _page = 0;
    _total = 0;
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
      final page = await _repository.list(planId, pageSize: pageSize);
      if (planId != _planId) return;
      _items = page.items;
      _page = 1;
      _total = page.total;
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
      final page = await _repository.list(
        planId,
        page: _page + 1,
        pageSize: pageSize,
      );
      if (planId != _planId) return;
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

  /// Throws [ApiFailure]. Reloads the list on success; the caller refreshes
  /// the envelopes and accounts, whose figures change.
  Future<TransactionData> create(NewTransaction draft) async {
    final created = await _repository.create(_planId!, draft);
    await refresh();
    return created;
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
