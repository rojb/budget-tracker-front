import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../accounts/accounts_controller.dart';
import '../common/feedback.dart';
import '../common/months.dart';
import '../envelopes/envelopes_controller.dart';
import 'transactions_controller.dart';
import 'transactions_repository.dart';

/// What 12 hands back to the screen that opened it: the movement was edited or
/// deleted, and which months the API recalculated. That screen (10 or 14) then
/// shows the toast of 49 with its "Deshacer".
sealed class TransactionOutcome {
  const TransactionOutcome({required this.before, required this.months});

  /// The movement as it was before the change (what "Deshacer" restores).
  final TransactionData before;

  /// Month keys recalculated, as the API returned them.
  final List<String> months;
}

class TransactionEdited extends TransactionOutcome {
  const TransactionEdited({required super.before, required super.months});
}

class TransactionDeleted extends TransactionOutcome {
  const TransactionDeleted({required super.before, required super.months});
}

/// "Agosto y septiembre actualizados." / "Septiembre actualizado."
String recalculatedDetail(List<String> months) {
  final text = monthsText(months);
  if (text.isEmpty) return '';
  final first = text[0].toUpperCase() + text.substring(1);
  return '$first ${months.length == 1 ? 'actualizado' : 'actualizados'}.';
}

/// Opens 12 for [transaction] from 10 or 14 and, when it comes back changed,
/// shows the toast of 49 over the screen. [onChanged] runs after the change
/// and after an undo, so the caller can reload what it shows.
Future<void> openTransaction(
  BuildContext context,
  TransactionData transaction, {
  required TransactionsController transactions,
  required EnvelopesController envelopes,
  required AccountsController accounts,
  VoidCallback? onChanged,
}) async {
  final outcome = await context.push<TransactionOutcome>(
    AppRoutes.editTransaction(transaction.id),
    extra: transaction,
  );
  if (outcome == null || !context.mounted) return;
  onChanged?.call();
  showChangeToast(
    context,
    outcome,
    transactions: transactions,
    envelopes: envelopes,
    accounts: accounts,
    onChanged: onChanged,
  );
}

/// Screen 49: the Neutral toast over the `NavCluster` after a save in 12 or a
/// delete in 27: "Recalculado" or "Movimiento eliminado", the months, and
/// "Deshacer". Undoing an edit sends the previous state back with the same
/// `PUT`; undoing a delete restores the transaction. An edit that cannot be
/// replayed (its original had a portion whose envelope was deleted) has no
/// "Deshacer".
void showChangeToast(
  BuildContext context,
  TransactionOutcome outcome, {
  required TransactionsController transactions,
  required EnvelopesController envelopes,
  required AccountsController accounts,
  VoidCallback? onChanged,
}) {
  final deleted = outcome is TransactionDeleted;
  final snapshot = NewTransaction.snapshotOf(outcome.before);
  final canUndo = deleted || snapshot != null;

  Future<void> undo() async {
    try {
      if (deleted) {
        await transactions.restore(outcome.before.id);
      } else {
        await transactions.update(outcome.before.id, snapshot!);
      }
      await Future.wait([envelopes.load(), accounts.load()]);
      onChanged?.call();
    } on ApiFailure catch (failure) {
      if (!context.mounted) return;
      if (failure.kind == ApiFailureKind.forbidden) {
        showForbidden(context);
      } else {
        showConnectionProblem(context);
      }
    }
  }

  showUiToast(
    context,
    variant: UiToastVariant.neutral,
    title: deleted ? 'Movimiento eliminado' : 'Recalculado',
    detail: recalculatedDetail(outcome.months),
    actionLabel: canUndo ? 'Deshacer' : null,
    onAction: canUndo ? undo : null,
    // Over the NavCluster of the tab screen (PRD-ux-spec.md 8, screen 49).
    bottomOffset: 100,
  );
}
