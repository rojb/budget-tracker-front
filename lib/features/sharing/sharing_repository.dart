import 'package:api_client/api_client.dart' as api;
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';
import '../plans/plans_repository.dart';

/// Role an invitation grants (the owner role is not transferable).
enum InviteRole {
  editor('Editor', 'Puede editar'),
  viewer('Lector', 'Solo lectura');

  const InviteRole(this.chip, this.memberLabel);

  /// Chip label in 21 ("Editor" / "Lector").
  final String chip;

  /// Member label in 16 ("Puede editar" / "Solo lectura").
  final String memberLabel;

  api.InvitationRole get apiRole => this == InviteRole.editor
      ? api.InvitationRole.editor
      : api.InvitationRole.viewer;

  static InviteRole of(api.InvitationRole role) =>
      role == api.InvitationRole.viewer ? InviteRole.viewer : InviteRole.editor;
}

class InvitationData {
  const InvitationData({
    required this.code,
    required this.role,
    required this.createdAt,
    required this.expiresAt,
    required this.link,
  });

  final String code;
  final InviteRole role;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String link;
}

class InvitationPreviewData {
  const InvitationPreviewData({
    required this.planName,
    required this.ownerName,
    required this.currency,
    required this.role,
  });

  final String planName;
  final String ownerName;
  final Currency currency;
  final InviteRole role;
}

/// Wraps the generated `SharingApi`; every error surfaces as [ApiFailure].
class SharingRepository {
  SharingRepository(this._gateway);

  final ApiGateway _gateway;

  api.SharingApi get _sharing => _gateway.client.getSharingApi();

  /// The plan's active invitation, or null when there is none.
  Future<InvitationData?> activeInvitation(String planId) async {
    try {
      return await guardApi(() async {
        final response = await _sharing.getInvitation(planId: planId);
        return _toData(response.data!);
      });
    } on ApiFailure catch (failure) {
      if (failure.kind == ApiFailureKind.notFound) return null;
      rethrow;
    }
  }

  Future<InvitationData> createInvitation(String planId, InviteRole role) =>
      guardApi(() async {
        final response = await _sharing.createInvitation(
          planId: planId,
          createInvitationRequest: api.CreateInvitationRequest(
            (b) => b..role = role.apiRole,
          ),
        );
        return _toData(response.data!);
      });

  Future<void> revokeInvitation(String planId) =>
      guardApi(() => _sharing.revokeInvitation(planId: planId));

  Future<InvitationPreviewData> preview(String code) => guardApi(() async {
    final preview = (await _sharing.previewInvitation(code: code)).data!;
    return InvitationPreviewData(
      planName: preview.planName,
      ownerName: preview.ownerName,
      currency: currencyOf(preview.currency.code),
      role: InviteRole.of(preview.role),
    );
  });

  Future<PlanData> accept(String code) => guardApi(() async {
    final response = await _sharing.acceptInvitation(code: code);
    return PlansRepository.toData(response.data!);
  });

  Future<void> updateMember(String planId, String userId, InviteRole role) =>
      guardApi(
        () => _sharing.updateMember(
          planId: planId,
          userId: userId,
          updateMemberRequest: api.UpdateMemberRequest(
            (b) => b..role = role.apiRole,
          ),
        ),
      );

  Future<void> removeMember(String planId, String userId) =>
      guardApi(() => _sharing.removeMember(planId: planId, userId: userId));

  static InvitationData _toData(api.Invitation invitation) => InvitationData(
    code: invitation.code,
    role: InviteRole.of(invitation.role),
    createdAt: invitation.createdAt,
    expiresAt: invitation.expiresAt,
    link: invitation.link,
  );
}
