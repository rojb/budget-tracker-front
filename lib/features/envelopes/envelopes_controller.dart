import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show ImageProvider;

import '../../core/api/api_failure.dart';
import '../plans/plans_controller.dart';
import 'envelopes_repository.dart';

/// Groups, envelopes and Ready to Assign of the active plan, shared by the Plan
/// tab (06 / 02 / 04), 31, 32, 35, 46 and the pickers. It reloads when the
/// active plan changes and after every mutation, because the figures come from
/// the API. The figures are those of the viewed month ([showMonth]), the
/// current one until the plan view moves (add-monthly-assignment).
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

  /// Month asked for by the plan view; null for the current month.
  String? _viewedMonth;

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
    _viewedMonth = null;
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
        _repository.board(planId, month: _viewedMonth),
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

  /// Loads the figures of [month] ("2026-11"), or of the current month when
  /// null; every later reload keeps that month (FR-15).
  Future<void> showMonth(String? month) {
    _viewedMonth = month;
    return load();
  }

  /// The envelopes and Ready to Assign of [month] without changing the viewed
  /// month (the month chips of 03).
  Future<EnvelopeBoard> boardOf(String month) =>
      _repository.board(_planId!, month: month);

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
    GoalData? goal,
  }) async {
    final envelope = await _repository.createEnvelope(
      _planId!,
      name: name,
      groupId: groupId,
      icon: icon,
      goal: goal,
    );
    await load();
    return envelope;
  }

  /// The envelopes with a goal that has a date, in the order of the board:
  /// the "Metas" of 01. Their state and progress come from the API.
  List<EnvelopeLineData> get goalLines => [
    for (final line in _lines)
      if (line.envelope.goal?.kind == GoalKind.targetByDate) line,
  ];

  /// One envelope of the loaded month with its activity (22).
  Future<EnvelopeDetailData> detail(String envelopeId) =>
      _repository.detail(_planId!, envelopeId, month: _month);

  /// Saves the name, icon or group, then sets or removes the goal ([goal] null
  /// removes it) and reloads (23). Throws [ApiFailure] (409 when the name is
  /// taken, 400 when the goal is invalid).
  Future<void> saveEnvelope(
    String envelopeId, {
    String? name,
    String? icon,
    String? groupId,
    GoalData? goal,
    bool hadGoal = false,
  }) async {
    final planId = _planId!;
    try {
      if (name != null || icon != null || groupId != null) {
        await _repository.updateEnvelope(
          planId,
          envelopeId,
          name: name,
          icon: icon,
          groupId: groupId,
        );
      }
      if (goal != null) {
        await _repository.setGoal(planId, envelopeId, goal);
      } else if (hadGoal) {
        await _repository.clearGoal(planId, envelopeId);
      }
    } finally {
      await load();
    }
  }

  /// Moves money inside the loaded month and reloads (24). Throws
  /// [ApiFailure] (409 when the source has less available than the amount).
  Future<MoveResult> moveMoney({
    required String fromEnvelopeId,
    required String toEnvelopeId,
    required int amountMinor,
  }) async {
    final result = await _repository.moveMoney(
      _planId!,
      fromEnvelopeId: fromEnvelopeId,
      toEnvelopeId: toEnvelopeId,
      amountMinor: amountMinor,
      month: _month,
    );
    await load();
    return result;
  }

  /// Throws [ApiFailure] (413 over 5 MB, 415 when not JPEG, PNG or WebP).
  Future<void> uploadPhoto(
    String envelopeId,
    List<int> bytes,
    String filename,
  ) async {
    await _repository.uploadPhoto(_planId!, envelopeId, bytes, filename);
    await load();
  }

  Future<void> applySuggestedPhoto(
    String envelopeId,
    String suggestionId,
  ) async {
    await _repository.applySuggestedPhoto(_planId!, envelopeId, suggestionId);
    await load();
  }

  Future<void> removePhoto(String envelopeId) async {
    await _repository.removePhoto(_planId!, envelopeId);
    await load();
  }

  Future<List<PhotoSuggestionData>> photoSuggestions() =>
      _repository.photoSuggestions();

  /// The photo or suggestion image at [path], with the bearer header.
  ImageProvider? imageFor(String? path) => _repository.image(path);

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
