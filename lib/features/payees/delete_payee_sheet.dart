import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'payees_repository.dart';

/// Screen 47 Eliminar beneficiario. Returns true on "Eliminar". The payee is
/// deleted logically, so its movements keep it (FR-05).
Future<bool?> showDeletePayeeSheet(BuildContext context, PayeeData payee) {
  final movements = payee.transactionCount == 0
      ? 'No tiene movimientos.'
      : 'Sus ${payee.movementsLabel} se conservan con este beneficiario.';
  return showUiSheet<bool>(
    context,
    builder: (sheetContext) => UiSheet(
      title: '¿Eliminar "${payee.name}"?',
      showClose: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: UiPayeeRow(
              initials: payee.initials,
              name: payee.name,
              subtitle: payee.movementsLabel,
              highlighted: true,
            ),
          ),
          const SizedBox(height: 12),
          UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.cornerDownRight,
            text: '$movements Deja de ofrecerse en movimientos nuevos.',
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
