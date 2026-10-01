import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../common/months.dart';
import '../envelopes/envelopes_controller.dart';
import 'transaction_rows.dart';
import 'transactions_repository.dart';

/// Screen 27 Eliminar movimiento: confirmation sheet opened by the trash of 12.
/// It shows the movement, the months a deletion recalculates ("Se recalcularán
/// agosto y septiembre.") and Cancelar / Eliminar (solid danger). Returns true
/// when the user confirms.
Future<bool?> showDeleteTransactionSheet(
  BuildContext context, {
  required TransactionData transaction,
  required Currency currency,
  required EnvelopesController envelopes,
}) {
  final months = monthsFrom(transaction.occurredAt);
  return showUiSheet<bool>(
    context,
    builder: (sheetContext) => UiSheet(
      title: '¿Eliminar este movimiento?',
      showClose: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: transactionRow(
              transaction,
              currency: currency,
              envelopes: envelopes,
              showAccount: true,
              timeWithDay: true,
            ),
          ),
          const SizedBox(height: 14),
          UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.history,
            title: months.length == 1
                ? 'Se recalculará ${monthsText(months)}.'
                : 'Se recalcularán ${monthsText(months)}.',
            text: 'Los saldos y Listo para asignar se actualizan al confirmar.',
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
