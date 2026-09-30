import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import 'envelopes_repository.dart';

/// Groups, envelopes and Ready to Assign of the active plan, shared by the Plan
/// tab (06 / 02), 31, 32, 35, 46 and the pickers. It reloads when the active
/// plan changes and after every mutation, because the figures come from the API.
class EnvelopesController extends ChangeNotifier {
  EnvelopesController(this._repository, this._plans) {
    _plans.addListener(_onPlan);
    _onPlan();
  }

  final EnvelopesRepository _repository;
  final PlansController _plans;

  String? _planId;
  bool _loading = false;
  bool _loaded = false;
  bool _failed = false;
  List<GroupData> _groups = const [];
  List<EnvelopeLineData> _lines = const [];
  int _readyToAssignMinor = 0;
  String? _month;

  bool get loading => _loading;

  /// True once the first load of the active plan finished (successfully).
  bool get loaded => _loaded;
  bool get failed => _failed;
  List<GroupData> get groups => _groups;
  List<EnvelopeLineData> get lines => _lines;
  int get readyToAssignMinor => _readyToAssignMinor;

  /// Budget month of the loaded figures ("2026-09"), null before the load.
  String? get month => _month;
  int get envelopeCount => _lines.length;

  GroupData? groupById(String? id) =>
      _groups.where((g) => g.id == id).firstOrNull;

  /// Envelopes of [groupId] in order; the ones without a group when null.
  List<EnvelopeLineData> linesOf(String? groupId) =>
      _lines.where((l) => l.envelope.groupId == groupId).toList();

  /// Σ available of the envelopes of [groupId] (the header subtotal).
  int subtotalOf(String? groupId) =>
      linesOf(groupId).fold(0, (sum, l) => sum + l.availableMinor);

  EnvelopeLineData? lineById(String id) =>
      _lines.where((l) => l.envelope.id == id).firstOrNull;

  void _onPlan() {
    final planId = _plans.activePlan?.id;
    if (planId == _planId) return;
    _planId = planId;
    _groups = const [];
    _lines = const [];
    _readyToAssignMinor = 0;
    _month = null;
    _loaded = false;
    _failed = false;
    if (planId == null) {
      notifyListeners();
      return;
    }
    load();
  }

  Future<void> load() async {
    final planId = _planId;
    if (planId == null) return;
    _loading = true;
    _failed = false;
    notifyListeners();
    try {
      final results = await Future.wait([
        _repository.groups(planId),
        _repository.board(planId),
      ]);
      if (planId != _planId) return;
      _groups = results[0] as List<GroupData>;
      final board = results[1] as EnvelopeBoard;
      _lines = board.lines;
      _readyToAssignMinor = board.readyToAssignMinor;
      _month = board.month;
      _loaded = true;
    } on ApiFailure {
      if (planId == _planId) _failed = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Throws [ApiFailure] (409 when the name is taken).
  Future<GroupData> createGroup(String name) async {
    final group = await _repository.createGroup(_planId!, name);
    await load();
    return group;
  }

  /// Throws [ApiFailure] (409 when the name is taken).
  Future<void> renameGroup(String groupId, String name) async {
    await _repository.renameGroup(_planId!, groupId, name);
    await load();
  }

  /// Throws [ApiFailure]. Its envelopes stay in the plan, without a group.
  Future<void> deleteGroup(String groupId) async {
    await _repository.deleteGroup(_planId!, groupId);
    await load();
  }

  /// Applies [orderedIds] right away and saves it; on failure the server order
  /// is restored and the [ApiFailure] is rethrown.
  Future<void> reorderGroups(List<String> orderedIds) async {
    final byId = {for (final g in _groups) g.id: g};
    _groups = [
      for (var i = 0; i < orderedIds.length; i++)
        GroupData(
          id: orderedIds[i],
          name: byId[orderedIds[i]]!.name,
          position: i,
          envelopeCount: byId[orderedIds[i]]!.envelopeCount,
        ),
    ];
    notifyListeners();
    try {
      await _repository.reorderGroups(_planId!, orderedIds);
    } on ApiFailure {
      await load();
      rethrow;
    }
    await load();
  }

  /// Throws [ApiFailure] (409 when the name is taken).
  Future<EnvelopeData> createEnvelope({
    required String name,
    String? groupId,
    String? icon,
  }) async {
    final envelope = await _repository.createEnvelope(
      _planId!,
      name: name,
      groupId: groupId,
      icon: icon,
    );
    await load();
    return envelope;
  }

  /// Throws [ApiFailure]. Its money returns to Ready to Assign.
  Future<void> deleteEnvelope(String envelopeId) async {
    await _repository.deleteEnvelope(_planId!, envelopeId);
    await load();
  }

  Future<List<TemplateGroupData>> template() => _repository.template();

  /// Throws [ApiFailure] (409 when the plan already has envelopes).
  Future<void> applyTemplate(List<String> envelopeNames) async {
    await _repository.applyTemplate(_planId!, envelopeNames);
    await load();
  }

  /// Throws [ApiFailure]. Returns the Ready to Assign after the assignment.
  Future<AssignmentResult> assignInitial(Map<String, int> amounts) async {
    final result = await _repository.assignInitial(_planId!, amounts);
    await load();
    return result;
  }

  @override
  void dispose() {
    _plans.removeListener(_onPlan);
    super.dispose();
  }
}
