import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'envelopes_repository.dart';

/// Screen 43 Eliminar sobre. Returns true on "Eliminar". The envelope's
/// movements are kept without an envelope and its available money returns to
/// Ready to Assign (its assignments are deleted with it).
Future<bool?> showDeleteEnvelopeSheet(
  BuildContext context, {
  required EnvelopeLineData line,
  required String? groupName,
  required Currency currency,
}) {
  final available = line.availableMinor;
  final subtitle = [
    ?groupName,
    '${formatMoney(available, currency)} disponible',
  ].join(' · ');
  return showUiSheet<bool>(
    context,
    builder: (sheetContext) => UiSheet(
      title: '¿Eliminar "${line.envelope.name}"?',
      showClose: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UiCard(
            padding: const EdgeInsets.all(16),
            child: UiEnvelopeRow(
              card: false,
              icon: uiEnvelopeIcon(line.envelope.icon),
              name: line.envelope.name,
              subtitle: subtitle,
            ),
          ),
          const SizedBox(height: 12),
          UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.cornerDownRight,
            title: 'Sus movimientos pasan a «Sin sobre»',
            text: available > 0
                ? 'Los ${formatMoney(available, currency)} disponibles vuelven '
                      'a Listo para asignar.'
                : 'No tiene dinero disponible que devolver.',
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
