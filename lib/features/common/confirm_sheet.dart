import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Destructive confirmation with Cancelar / [action] (solid danger).
Future<bool?> confirmSheet(
  BuildContext context, {
  required String title,
  required String detail,
  required String action,
}) {
  return showUiSheet<bool>(
    context,
    builder: (sheetContext) => UiSheet(
      title: title,
      showClose: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.cornerDownRight,
            text: detail,
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
                  label: action,
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
