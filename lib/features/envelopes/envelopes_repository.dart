import 'package:api_client/api_client.dart' as api;
import 'package:dio/dio.dart' show MultipartFile;
import 'package:flutter/painting.dart' show ImageProvider, NetworkImage;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';
import '../transactions/transactions_repository.dart';

class GroupData {
  const GroupData({
    required this.id,
    required this.name,
    required this.position,
    required this.envelopeCount,
  });

  final String id;
  final String name;
  final int position;
  final int envelopeCount;

  /// "4 sobres" (the subtitle of `GroupRow`).
  String get envelopesLabel =>
      '$envelopeCount ${envelopeCount == 1 ? 'sobre' : 'sobres'}';

  static GroupData fromApi(api.EnvelopeGroup group) => GroupData(
    id: group.id,
    name: group.name,
    position: group.position,
    envelopeCount: group.envelopeCount,
  );
}

/// Kind of goal of an envelope: an amount to assign every month, or an amount
/// to have by a date.
enum GoalKind { monthly, targetByDate }

/// The goal of an envelope, as the user set it (the API derives the rest).
class GoalData {
  const GoalData({required this.kind, required this.targetMinor, this.dueDate});

  final GoalKind kind;
  final int targetMinor;

  /// Local calendar date (no time); only for [GoalKind.targetByDate].
  final DateTime? dueDate;

  static GoalData fromApi(api.EnvelopeGoal goal) => GoalData(
    kind: goal.type == api.EnvelopeGoalType.targetByDate
        ? GoalKind.targetByDate
        : GoalKind.monthly,
    targetMinor: goal.targetMinor,
    dueDate: goal.dueDate?.toDateTime(),
  );

  api.EnvelopeGoal toApi() => api.EnvelopeGoal(
    (b) => b
      ..type = kind == GoalKind.targetByDate
          ? api.EnvelopeGoalType.targetByDate
          : api.EnvelopeGoalType.monthly
      ..targetMinor = targetMinor
      ..dueDate = dueDate?.toDate(),
  );
}

/// Derived state of an envelope in a month. Only the API computes it; 02, 22,
/// 05 and 24 render it (FR-20).
enum LineState { funded, underfunded, overspent }

/// Progress of a goal in a month, derived by the API from the goal and the
/// budget engine's figures.
class GoalStatusData {
  const GoalStatusData({
    required this.requiredMinor,
    required this.missingMinor,
    required this.savedMinor,
    required this.remainingMinor,
    required this.percent,
    this.monthsRemaining,
  });

  /// What the month has to assign to be on track.
  final int requiredMinor;

  /// What the month still needs ("Falta").
  final int missingMinor;
  final int savedMinor;

  /// What is left to reach the target.
  final int remainingMinor;

  /// 0..100, saved over target.
  final int percent;

  /// Months to the due month; only for a goal with a date.
  final int? monthsRemaining;

  static GoalStatusData fromApi(api.GoalStatus status) => GoalStatusData(
    requiredMinor: status.requiredMinor,
    missingMinor: status.missingMinor,
    savedMinor: status.savedMinor,
    remainingMinor: status.remainingMinor,
    percent: status.percent,
    monthsRemaining: status.monthsRemaining,
  );
}

class EnvelopeData {
  const EnvelopeData({
    required this.id,
    required this.name,
    required this.icon,
    required this.position,
    this.groupId,
    this.goal,
    this.photoUrl,
  });

  final String id;
  final String name;

  /// Name of the API's `EnvelopeIcon` (mapped by `uiEnvelopeIcon`).
  final String icon;
  final String? groupId;
  final int position;
  final GoalData? goal;

  /// Path of the photo, relative to the API (served to members with the bearer
  /// token); null when the envelope has no photo.
  final String? photoUrl;

  static EnvelopeData fromApi(api.Envelope envelope) => EnvelopeData(
    id: envelope.id,
    name: envelope.name,
    icon: envelope.icon.name,
    groupId: envelope.groupId,
    position: envelope.position,
    goal: envelope.goal == null ? null : GoalData.fromApi(envelope.goal!),
    photoUrl: envelope.photoUrl,
  );
}

/// An envelope with the figures the API derives for the month, its state and,
/// with a goal, the status of the goal.
class EnvelopeLineData {
  const EnvelopeLineData({
    required this.envelope,
    required this.assignedMinor,
    required this.spentMinor,
    required this.availableMinor,
    this.state = LineState.funded,
    this.goalStatus,
  });

  final EnvelopeData envelope;
  final int assignedMinor;

  /// Net outflow of the month as the engine derives it (expenses minus income
  /// sent to the envelope); negative when income exceeds expenses.
  final int spentMinor;
  final int availableMinor;
  final LineState state;
  final GoalStatusData? goalStatus;

  static EnvelopeLineData fromApi(api.EnvelopeLine line) => EnvelopeLineData(
    envelope: EnvelopeData.fromApi(line.envelope),
    assignedMinor: line.assignedMinor,
    spentMinor: line.spentMinor,
    availableMinor: line.availableMinor,
    state: switch (line.state) {
      api.EnvelopeState.overspent => LineState.overspent,
      api.EnvelopeState.underfunded => LineState.underfunded,
      _ => LineState.funded,
    },
    goalStatus: line.goalStatus == null
        ? null
        : GoalStatusData.fromApi(line.goalStatus!),
  );
}

/// One envelope with its month's activity (22).
class EnvelopeDetailData {
  const EnvelopeDetailData({
    required this.month,
    required this.line,
    required this.carryoverMinor,
    required this.activity,
    required this.activityTotal,
  });

  final String month;
  final EnvelopeLineData line;
  final int carryoverMinor;

  /// Transactions of the month with a portion on the envelope, newest first.
  final List<TransactionData> activity;
  final int activityTotal;
}

/// Result of moving money (24): the updated lines of both envelopes.
class MoveResult {
  const MoveResult({
    required this.month,
    required this.readyToAssignMinor,
    required this.from,
    required this.to,
  });

  final String month;
  final int readyToAssignMinor;
  final EnvelopeLineData from;
  final EnvelopeLineData to;
}

/// A suggested goal photo (50).
class PhotoSuggestionData {
  const PhotoSuggestionData({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;

  /// Path of the image, relative to the API.
  final String imageUrl;
}

class EnvelopeBoard {
  const EnvelopeBoard({
    required this.month,
    required this.readyToAssignMinor,
    required this.lines,
  });

  final String month;
  final int readyToAssignMinor;
  final List<EnvelopeLineData> lines;
}

class TemplateEnvelopeData {
  const TemplateEnvelopeData({required this.name, required this.icon});

  final String name;
  final String icon;
}

class TemplateGroupData {
  const TemplateGroupData({required this.name, required this.envelopes});

  final String name;
  final List<TemplateEnvelopeData> envelopes;
}

class AssignmentResult {
  const AssignmentResult({
    required this.month,
    required this.assignedMinor,
    required this.readyToAssignMinor,
  });

  final String month;
  final int assignedMinor;
  final int readyToAssignMinor;
}

/// Wraps the generated `EnvelopesApi`; every error surfaces as [ApiFailure].
class EnvelopesRepository {
  EnvelopesRepository(this._gateway);

  final ApiGateway _gateway;

  api.EnvelopesApi get _api => _gateway.client.getEnvelopesApi();

  /// The image served at [path] (a goal photo or a suggestion, relative to the
  /// API), requested with the bearer token the API demands; null without a
  /// path. Photos change URL when they change, so Flutter's image cache never
  /// serves a stale one.
  ImageProvider? image(String? path) => path == null
      ? null
      : NetworkImage(
          '${_gateway.baseUrl}$path',
          headers: _gateway.authorizationHeaders,
        );

  Future<List<GroupData>> groups(String planId) => guardApi(() async {
    final response = await _api.listEnvelopeGroups(planId: planId);
    return (response.data?.map(GroupData.fromApi) ?? const <GroupData>[])
        .toList();
  });

  Future<EnvelopeBoard> board(String planId, {String? month}) => guardApi(
    () async {
      final response = await _api.listEnvelopes(planId: planId, month: month);
      final list = response.data!;
      return EnvelopeBoard(
        month: list.month,
        readyToAssignMinor: list.readyToAssignMinor,
        lines: [for (final line in list.items) EnvelopeLineData.fromApi(line)],
      );
    },
  );

  /// One envelope of a month with its activity (22). [month] is the month the
  /// board was loaded for; the current month when null.
  Future<EnvelopeDetailData> detail(
    String planId,
    String envelopeId, {
    String? month,
  }) => guardApi(() async {
    final response = await _api.getEnvelopeDetail(
      planId: planId,
      envelopeId: envelopeId,
      month: month,
    );
    final detail = response.data!;
    return EnvelopeDetailData(
      month: detail.month,
      line: EnvelopeLineData.fromApi(detail.line),
      carryoverMinor: detail.carryoverMinor,
      activity: detail.activity.map(TransactionData.fromApi).toList(),
      activityTotal: detail.activityTotal,
    );
  });

  /// Throws [ApiFailure] (400 when the goal is invalid).
  Future<EnvelopeData> setGoal(
    String planId,
    String envelopeId,
    GoalData goal,
  ) => guardApi(() async {
    final response = await _api.setEnvelopeGoal(
      planId: planId,
      envelopeId: envelopeId,
      envelopeGoal: goal.toApi(),
    );
    return EnvelopeData.fromApi(response.data!);
  });

  Future<EnvelopeData> clearGoal(String planId, String envelopeId) =>
      guardApi(() async {
        final response = await _api.clearEnvelopeGoal(
          planId: planId,
          envelopeId: envelopeId,
        );
        return EnvelopeData.fromApi(response.data!);
      });

  /// Edits the name, icon or group (23). Throws [ApiFailure] (409 when the
  /// name is taken).
  Future<EnvelopeData> updateEnvelope(
    String planId,
    String envelopeId, {
    String? name,
    String? icon,
    String? groupId,
  }) => guardApi(() async {
    final response = await _api.updateEnvelope(
      planId: planId,
      envelopeId: envelopeId,
      updateEnvelopeRequest: api.UpdateEnvelopeRequest(
        (b) => b
          ..name = name
          ..groupId = groupId
          ..icon = icon == null ? null : api.EnvelopeIcon.valueOf(icon),
      ),
    );
    return EnvelopeData.fromApi(response.data!);
  });

  /// Throws [ApiFailure] (409 when the source has less available than the
  /// amount).
  Future<MoveResult> moveMoney(
    String planId, {
    required String fromEnvelopeId,
    required String toEnvelopeId,
    required int amountMinor,
    String? month,
  }) => guardApi(() async {
    final response = await _api.moveMoney(
      planId: planId,
      moveMoneyRequest: api.MoveMoneyRequest(
        (b) => b
          ..fromEnvelopeId = fromEnvelopeId
          ..toEnvelopeId = toEnvelopeId
          ..amountMinor = amountMinor
          ..month = month,
      ),
    );
    final result = response.data!;
    return MoveResult(
      month: result.month,
      readyToAssignMinor: result.readyToAssignMinor,
      from: EnvelopeLineData.fromApi(result.from),
      to: EnvelopeLineData.fromApi(result.to),
    );
  });

  /// Uploads [bytes] as the photo (the API decides the type by content).
  /// Throws [ApiFailure] (413 over 5 MB, 415 when not JPEG, PNG or WebP).
  Future<EnvelopeData> uploadPhoto(
    String planId,
    String envelopeId,
    List<int> bytes,
    String filename,
  ) => guardApi(() async {
    final response = await _api.uploadEnvelopePhoto(
      planId: planId,
      envelopeId: envelopeId,
      file: MultipartFile.fromBytes(bytes, filename: filename),
    );
    return EnvelopeData.fromApi(response.data!);
  });

  Future<EnvelopeData> applySuggestedPhoto(
    String planId,
    String envelopeId,
    String suggestionId,
  ) => guardApi(() async {
    final response = await _api.applySuggestedEnvelopePhoto(
      planId: planId,
      envelopeId: envelopeId,
      suggestedPhotoRequest: api.SuggestedPhotoRequest(
        (b) => b..suggestionId = api.PhotoSuggestionId.valueOf(suggestionId),
      ),
    );
    return EnvelopeData.fromApi(response.data!);
  });

  Future<EnvelopeData> removePhoto(String planId, String envelopeId) =>
      guardApi(() async {
        final response = await _api.deleteEnvelopePhoto(
          planId: planId,
          envelopeId: envelopeId,
        );
        return EnvelopeData.fromApi(response.data!);
      });

  Future<List<PhotoSuggestionData>> photoSuggestions() => guardApi(() async {
    final response = await _api.listPhotoSuggestions();
    return [
      for (final suggestion in response.data!)
        PhotoSuggestionData(
          id: suggestion.id.name,
          name: suggestion.name,
          imageUrl: suggestion.imageUrl,
        ),
    ];
  });

  Future<GroupData> createGroup(String planId, String name) =>
      guardApi(() async {
        final response = await _api.createEnvelopeGroup(
          planId: planId,
          createEnvelopeGroupRequest: api.CreateEnvelopeGroupRequest(
            (b) => b..name = name,
          ),
        );
        return GroupData.fromApi(response.data!);
      });

  Future<GroupData> renameGroup(String planId, String groupId, String name) =>
      guardApi(() async {
        final response = await _api.updateEnvelopeGroup(
          planId: planId,
          groupId: groupId,
          updateEnvelopeGroupRequest: api.UpdateEnvelopeGroupRequest(
            (b) => b..name = name,
          ),
        );
        return GroupData.fromApi(response.data!);
      });

  Future<void> deleteGroup(String planId, String groupId) => guardApi(() async {
    await _api.deleteEnvelopeGroup(planId: planId, groupId: groupId);
  });

  Future<void> reorderGroups(String planId, List<String> groupIds) =>
      guardApi(() async {
        await _api.reorderEnvelopeGroups(
          planId: planId,
          reorderEnvelopeGroupsRequest: api.ReorderEnvelopeGroupsRequest(
            (b) => b.groupIds.replace(groupIds),
          ),
        );
      });

  Future<EnvelopeData> createEnvelope(
    String planId, {
    required String name,
    String? groupId,
    String? icon,
    GoalData? goal,
  }) => guardApi(() async {
    final response = await _api.createEnvelope(
      planId: planId,
      createEnvelopeRequest: api.CreateEnvelopeRequest(
        (b) => b
          ..name = name
          ..groupId = groupId
          ..icon = icon == null ? null : api.EnvelopeIcon.valueOf(icon)
          ..goal = goal?.toApi().toBuilder(),
      ),
    );
    return EnvelopeData.fromApi(response.data!);
  });

  Future<void> deleteEnvelope(String planId, String envelopeId) =>
      guardApi(() async {
        await _api.deleteEnvelope(planId: planId, envelopeId: envelopeId);
      });

  Future<List<TemplateGroupData>> template() => guardApi(() async {
    final response = await _api.getEnvelopeTemplate();
    return [
      for (final group in response.data!.groups)
        TemplateGroupData(
          name: group.name,
          envelopes: [
            for (final envelope in group.envelopes)
              TemplateEnvelopeData(
                name: envelope.name,
                icon: envelope.icon.name,
              ),
          ],
        ),
    ];
  });

  Future<void> applyTemplate(String planId, List<String> envelopeNames) =>
      guardApi(() async {
        await _api.applyEnvelopeTemplate(
          planId: planId,
          applyEnvelopeTemplateRequest: api.ApplyEnvelopeTemplateRequest(
            (b) => b.envelopeNames.replace(envelopeNames),
          ),
        );
      });

  Future<AssignmentResult> assignInitial(
    String planId,
    Map<String, int> amountsByEnvelope,
  ) => guardApi(() async {
    final response = await _api.applyInitialAssignment(
      planId: planId,
      initialAssignmentRequest: api.InitialAssignmentRequest(
        (b) => b.assignments.replace([
          for (final entry in amountsByEnvelope.entries)
            api.InitialAssignment(
              (a) => a
                ..envelopeId = entry.key
                ..amountMinor = entry.value,
            ),
        ]),
      ),
    );
    final result = response.data!;
    return AssignmentResult(
      month: result.month,
      assignedMinor: result.assignedMinor,
      readyToAssignMinor: result.readyToAssignMinor,
    );
  });
}
