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
/// - caption: the account in 10; in 14 (which already is the account) the group
///   of the envelope, or "A + B" with the envelope names of a split;
/// - icon: the envelope's, a split icon for a split, the income arrow for every
///   income.
///
/// [timeWithDay] draws the time as "Hoy, 14:32" (the confirmation of 27).
UiTxRow transactionRow(
  TransactionData transaction, {
  required Currency currency,
  required EnvelopesController envelopes,
  bool showAccount = true,
  bool timeWithDay = false,
  VoidCallback? onTap,
}) {
  final money = formatMoney(transaction.amountMinor, currency);
  final splits = transaction.splits;
  final time = timeWithDay
      ? dateTimeLabel(transaction.occurredAt)
      : timeLabel(transaction.occurredAt);
  final first = splits.isEmpty ? null : splits.first;
  final String destination;
  final IconData icon;
  if (!transaction.isExpense) {
    // Every income draws the income arrow, as the render of 10 does.
    destination = first?.envelopeId == null
        ? 'Listo para asignar'
        : (first!.envelopeName ?? 'Sin sobre');
    icon = UiIcons.arrowDownLeft;
  } else if (splits.length > 1) {
    destination = '${splits.length} sobres';
    icon = UiIcons.split;
  } else if (first?.envelopeId != null) {
    final line = envelopes.lineById(first!.envelopeId!);
    destination = first.envelopeName ?? 'Sin sobre';
    icon = line == null ? UiIcons.tag : uiEnvelopeIcon(line.envelope.icon);
  } else {
    destination = 'Sin sobre';
    icon = UiIcons.tag;
  }
  return UiTxRow(
    icon: icon,
    title:
        transaction.payeeName ?? transaction.description ?? 'Sin beneficiario',
    subtitle: '$destination · $time',
    amount: transaction.isExpense ? '−$money' : '+$money',
    caption: showAccount
        ? transaction.accountName
        : _envelopeCaption(transaction, envelopes),
    variant: transaction.isExpense
        ? UiTxRowVariant.expense
        : UiTxRowVariant.income,
    onTap: onTap,
  );
}

// Under the amount in 14: "Día a día" for one envelope, "Farmacia + Súper" for a split.
String? _envelopeCaption(
  TransactionData transaction,
  EnvelopesController envelopes,
) {
  final splits = transaction.splits;
  if (splits.length > 1) {
    final names = [
      for (final split in splits)
        if (split.envelopeName != null) split.envelopeName!,
    ];
    return names.isEmpty ? null : names.join(' + ');
  }
  final id = splits.firstOrNull?.envelopeId;
  final line = id == null ? null : envelopes.lineById(id);
  if (line == null) return null;
  return envelopes.groupById(line.envelope.groupId)?.name ?? 'Sin grupo';
}
