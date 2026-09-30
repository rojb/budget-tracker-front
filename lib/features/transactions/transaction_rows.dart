import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import '../common/dates.dart';
import '../envelopes/envelopes_controller.dart';
import 'transactions_repository.dart';

/// The `TxRow` of a transaction, as 10 Movimientos and 14 Detalle de cuenta
/// draw it (PRD-ux-spec.md 8, 9.1):
/// - title: the payee, else the description, else "Sin beneficiario";
/// - subtitle: envelope and time ("Supermercado · 14:32"), "N sobres · time" for
///   a split, "Listo para asignar · time" for an income without envelope;
/// - amount: `−$ X` for an expense, `+$ X` in a lavender capsule for an income;
/// - caption: the account (10 only; 14 already is the account);
/// - icon: the envelope's, a split icon for a split, an arrow for an income to
///   Ready to Assign.
UiTxRow transactionRow(
  TransactionData transaction, {
  required Currency currency,
  required EnvelopesController envelopes,
  bool showAccount = true,
  VoidCallback? onTap,
}) {
  final money = formatMoney(transaction.amountMinor, currency);
  final splits = transaction.splits;
  final time = timeLabel(transaction.occurredAt);
  final first = splits.isEmpty ? null : splits.first;
  final String destination;
  final IconData icon;
  if (splits.length > 1) {
    destination = '${splits.length} sobres';
    icon = UiIcons.split;
  } else if (first?.envelopeId != null) {
    final line = envelopes.lineById(first!.envelopeId!);
    destination = first.envelopeName ?? 'Sin sobre';
    icon = line == null ? UiIcons.tag : uiEnvelopeIcon(line.envelope.icon);
  } else if (transaction.isExpense) {
    destination = 'Sin sobre';
    icon = UiIcons.tag;
  } else {
    destination = 'Listo para asignar';
    icon = UiIcons.arrowDownLeft;
  }
  return UiTxRow(
    icon: icon,
    title:
        transaction.payeeName ?? transaction.description ?? 'Sin beneficiario',
    subtitle: '$destination · $time',
    amount: transaction.isExpense ? '−$money' : '+$money',
    caption: showAccount ? transaction.accountName : null,
    variant: transaction.isExpense
        ? UiTxRowVariant.expense
        : UiTxRowVariant.income,
    onTap: onTap,
  );
}
