import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../common/confirm_sheet.dart';
import '../plans/plans_repository.dart';
import 'sharing_repository.dart';

/// What the owner picked in the role sheet of 16.
sealed class MemberAction {
  const MemberAction();
}

class ChangeRole extends MemberAction {
  const ChangeRole(this.role);
  final InviteRole role;
}

class RemoveMember extends MemberAction {
  const RemoveMember();
}

/// Role sheet of 16 (owner only): "Puede editar", "Solo lectura" or "Quitar
/// del plan" (confirmed in a second step, §6.1 rule 2).
Future<MemberAction?> showMemberRoleSheet(
  BuildContext context,
  PlanMemberData member,
) async {
  final action = await showUiSheet<MemberAction>(
    context,
    builder: (sheetContext) => UiSheet(
      title: member.name,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final role in InviteRole.values) ...[
            UiButton(
              label: role.memberLabel,
              icon: _isRole(member, role) ? UiIcons.check : null,
              variant: _isRole(member, role)
                  ? UiButtonVariant.primary
                  : UiButtonVariant.white,
              onPressed: () => Navigator.of(sheetContext).pop(ChangeRole(role)),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          UiMenuRow(
            icon: UiIcons.logOut,
            label: 'Quitar del plan',
            destructive: true,
            onTap: () => Navigator.of(sheetContext).pop(const RemoveMember()),
          ),
        ],
      ),
    ),
  );
  if (action is! RemoveMember || !context.mounted) return action;
  final confirmed = await confirmSheet(
    context,
    title: '¿Quitar a ${member.name}?',
    detail: 'Deja de ver el plan. Lo que cargó se conserva.',
    action: 'Quitar',
  );
  return confirmed == true ? action : null;
}

bool _isRole(PlanMemberData member, InviteRole role) =>
    (role == InviteRole.editor && member.role == PlanRole.editor) ||
    (role == InviteRole.viewer && member.role == PlanRole.viewer);
