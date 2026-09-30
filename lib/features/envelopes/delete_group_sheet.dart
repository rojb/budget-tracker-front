import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'envelopes_repository.dart';

/// Screen 44 Eliminar grupo. Returns true on "Eliminar". The group's envelopes
/// are kept, without a group, with their money and movements.
Future<bool?> showDeleteGroupSheet(BuildContext context, GroupData group) {
  final count = group.envelopeCount;
  final title = switch (count) {
    0 => 'No tiene sobres',
    1 => 'Su sobre pasa a «Sin grupo»',
    _ => 'Sus $count sobres pasan a «Sin grupo»',
  };
  return showUiSheet<bool>(
    context,
    builder: (sheetContext) => UiSheet(
      title: '¿Eliminar "${group.name}"?',
      showClose: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: UiGroupRow(
              variant: UiGroupRowVariant.summary,
              name: group.name,
              subtitle: group.envelopesLabel,
            ),
          ),
          const SizedBox(height: 12),
          UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.cornerDownRight,
            title: title,
            text: 'No se pierde dinero ni movimientos.',
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: UiButton(
                  label: 'Cancelar',
                  variant: UiButtonVariant.white,
                  onPressed: () => Navigator.of(sheetContext).pop(false),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: UiButton(
                  label: 'Eliminar',
                  variant: UiButtonVariant.danger,
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
