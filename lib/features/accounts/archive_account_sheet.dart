import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'accounts_repository.dart';

/// Screen 48 Archivar cuenta: confirmation sheet. Returns true on "Archivar".
Future<bool?> showArchiveAccountSheet(
  BuildContext context,
  AccountData account,
) {
  return showUiSheet<bool>(
    context,
    builder: (sheetContext) => UiSheet(
      title: '¿Archivar "${account.name}"?',
      showClose: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UiCard(
            child: UiAccountRow(
              icon: account.kind.icon,
              name: account.name,
              subtitle: account.kind.label,
              amount: '',
            ),
          ),
          const SizedBox(height: 12),
          const UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.cornerDownRight,
            title: 'Deja de sumar al saldo total.',
            text: 'Sus movimientos se conservan.',
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
                  label: 'Archivar',
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
