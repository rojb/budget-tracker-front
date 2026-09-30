import 'package:api_client/api_client.dart' as api;

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

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

class EnvelopeData {
  const EnvelopeData({
    required this.id,
    required this.name,
    required this.icon,
    required this.position,
    this.groupId,
  });

  final String id;
  final String name;

  /// Name of the API's `EnvelopeIcon` (mapped by `uiEnvelopeIcon`).
  final String icon;
  final String? groupId;
  final int position;

  static EnvelopeData fromApi(api.Envelope envelope) => EnvelopeData(
    id: envelope.id,
    name: envelope.name,
    icon: envelope.icon.name,
    groupId: envelope.groupId,
    position: envelope.position,
  );
}

/// An envelope with the figures the API derives for the month.
class EnvelopeLineData {
  const EnvelopeLineData({
    required this.envelope,
    required this.assignedMinor,
    required this.availableMinor,
  });

  final EnvelopeData envelope;
  final int assignedMinor;
  final int availableMinor;

  /// Spending is not derived yet (it arrives with `add-transactions`), so the
  /// part of the assignment that is gone is the assignment minus what is left.
  int get spentMinor => assignedMinor - availableMinor;
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

  Future<List<GroupData>> groups(String planId) => guardApi(() async {
    final response = await _api.listEnvelopeGroups(planId: planId);
    return (response.data?.map(GroupData.fromApi) ?? const <GroupData>[])
        .toList();
  });

  Future<EnvelopeBoard> board(String planId, {String? month}) =>
      guardApi(() async {
        final response = await _api.listEnvelopes(planId: planId, month: month);
        final list = response.data!;
        return EnvelopeBoard(
          month: list.month,
          readyToAssignMinor: list.readyToAssignMinor,
          lines: [
            for (final line in list.items)
              EnvelopeLineData(
                envelope: EnvelopeData.fromApi(line.envelope),
                assignedMinor: line.assignedMinor,
                availableMinor: line.availableMinor,
              ),
          ],
        );
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
  }) => guardApi(() async {
    final response = await _api.createEnvelope(
      planId: planId,
      createEnvelopeRequest: api.CreateEnvelopeRequest(
        (b) => b
          ..name = name
          ..groupId = groupId
          ..icon = icon == null ? null : api.EnvelopeIcon.valueOf(icon),
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
