import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import '../envelopes/delete_envelope_sheet.dart';
import '../envelopes/envelopes_controller.dart';
import '../envelopes/envelopes_repository.dart';
import '../plans/plans_controller.dart';
import 'goal_photo_sheet.dart';

/// Screen 40 Opciones de meta: the sheet of the "…" of 05 with "Cambiar foto"
/// (→ 50, which comes back to this sheet), "Editar meta" (→ 23) and the red
/// "Eliminar meta", which asks through 43 and then deletes the envelope (a goal
/// is an envelope) and returns to 01.
Future<void> showGoalOptionsSheet(
  BuildContext context, {
  required EnvelopeLineData line,
  required PlansController plans,
  required EnvelopesController envelopes,
}) {
  final envelope = line.envelope;
  return showUiSheet<void>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Opciones de meta',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UiMenuRow(
            icon: UiIcons.image,
            label: 'Cambiar foto',
            onTap: () => showGoalPhotoSheet(
              sheetContext,
              envelopes: envelopes,
              icon: uiEnvelopeIcon(envelope.icon),
              envelopeId: envelope.id,
            ),
          ),
          UiMenuRow(
            icon: UiIcons.pencil,
            label: 'Editar meta',
            onTap: () {
              Navigator.of(sheetContext).pop();
              context.push(AppRoutes.editEnvelope(envelope.id));
            },
          ),
          UiMenuRow(
            icon: UiIcons.trash,
            label: 'Eliminar meta',
            destructive: true,
            onTap: () async {
              Navigator.of(sheetContext).pop();
              await _delete(context, line, plans, envelopes);
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> _delete(
  BuildContext context,
  EnvelopeLineData line,
  PlansController plans,
  EnvelopesController envelopes,
) async {
  final group = envelopes.groupById(line.envelope.groupId);
  final confirmed = await showDeleteEnvelopeSheet(
    context,
    line: line,
    groupName: group?.name,
    currency: plans.currency,
  );
  if (confirmed != true || !context.mounted) return;
  try {
    await envelopes.deleteEnvelope(line.envelope.id);
    if (!context.mounted) return;
    context.go(AppRoutes.home);
    showUiToast(
      context,
      variant: UiToastVariant.info,
      title: 'Meta eliminada',
      detail: 'Su disponible volvió a Listo para asignar.',
      bottomOffset: 100,
    );
  } on ApiFailure catch (failure) {
    if (!context.mounted) return;
    failure.kind == ApiFailureKind.forbidden
        ? showForbidden(context)
        : showConnectionProblem(context);
  }
}
