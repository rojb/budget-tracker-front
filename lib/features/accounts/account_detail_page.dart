import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/confirm_sheet.dart';
import '../common/day_groups.dart';
import '../common/dates.dart';
import '../common/feedback.dart';
import '../common/months.dart';
import '../envelopes/envelopes_controller.dart';
import '../plans/plans_controller.dart';
import '../transactions/transaction_change.dart';
import '../transactions/transaction_rows.dart';
import '../transactions/transactions_controller.dart';
import '../transactions/transactions_repository.dart';
import 'accounts_controller.dart';
import 'accounts_page.dart';
import 'accounts_repository.dart';
import 'transfers_repository.dart';

/// Screen 14 Detalle de cuenta: balance, what entered and left this month and
/// the account's movements, its transactions and its transfers together,
/// grouped by day.
class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({
    required this.accountId,
    required this.accounts,
    required this.plans,
    required this.transfers,
    required this.transactions,
    required this.envelopes,
    super.key,
  });

  final String accountId;
  final AccountsController accounts;
  final PlansController plans;
  final TransfersRepository transfers;
  final TransactionsController transactions;
  final EnvelopesController envelopes;

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  AccountDetailData? _detail;
  List<_Movement> _movements = const [];
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    widget.accounts.addListener(_load);
    _load();
  }

  @override
  void dispose() {
    widget.accounts.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        widget.accounts.detail(widget.accountId),
        widget.transfers.forAccount(
          widget.plans.activePlan!.id,
          widget.accountId,
        ),
        widget.transactions.forAccount(widget.accountId),
      ]);
      final movements = <_Movement>[
        for (final transfer in results[1] as List<TransferData>)
          _Movement(transfer.occurredAt, transfer: transfer),
        for (final transaction in results[2] as List<TransactionData>)
          _Movement(transaction.occurredAt, transaction: transaction),
      ]..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
      if (!mounted) return;
      setState(() {
        _detail = results[0] as AccountDetailData;
        _movements = movements;
      });
    } on ApiFailure {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = _detail;
    final currency = widget.plans.currency;
    final account = widget.accounts.byId(widget.accountId) ?? detail?.account;
    final month = detail == null
        ? DateTime.now()
        : DateTime(
            int.parse(detail.month.substring(0, 4)),
            int.parse(detail.month.substring(5, 7)),
          );
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            UiIconButton(
              icon: UiIcons.chevronLeft,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Volver',
              onPressed: () => context.pop(),
            ),
            const Spacer(),
            UiIconButton(
              icon: UiIcons.arrowLeftRight,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Transferir',
              onPressed: () =>
                  context.push(AppRoutes.transferFrom(widget.accountId)),
            ),
            const SizedBox(width: 8),
            UiIconButton(
              icon: UiIcons.pencil,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Editar cuenta',
              onPressed: account == null
                  ? null
                  : () => context.push(AppRoutes.editAccount(account.id)),
            ),
          ],
        ),
        const SizedBox(height: 22),
        if (account == null)
          Text(
            _failed ? 'No pudimos cargar la cuenta' : '',
            style: UiTypography.title,
          )
        else ...[
          Text(account.name, style: UiTypography.custom(30)),
          const SizedBox(height: 4),
          Text(accountSubtitle(account, currency), style: UiTypography.caption),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatMoney(account.balanceMinor, currency),
              style: UiTypography.custom(48, weight: 300),
            ),
          ),
          const SizedBox(height: 16),
          UiJoinedCard(
            primaryValue: formatMoney(detail?.inflowMinor ?? 0, currency),
            primaryLabel: 'Entró en ${monthShort(month)}',
            secondaryValue: formatMoney(detail?.outflowMinor ?? 0, currency),
            secondaryLabel: 'Salió',
            secondaryIsAmount: true,
          ),
          const SizedBox(height: 22),
          if (_movements.isEmpty)
            UiCard(
              padding: const EdgeInsets.all(22),
              child: Text(
                'Todavía no hay movimientos',
                style: UiTypography.custom(16, color: UiColors.inkMuted),
              ),
            )
          else
            ..._movementGroups(context, currency),
        ],
      ],
    );
  }

  // Transfers grouped by local day, newest first (PRD-ux-spec.md 6.1 rule 5).
  // Transactions and transfers together, newest first, grouped by day
  // (PRD-ux-spec.md 6.1 rule 5). A transaction opens 12 Editar movimiento; a
  // transfer offers its deletion.
  List<Widget> _movementGroups(BuildContext context, Currency currency) {
    return buildDayGroups<_Movement>(
      _movements,
      occurredAt: (movement) => movement.occurredAt,
      rowBuilder: (movement) {
        final transaction = movement.transaction;
        if (transaction != null) {
          return transactionRow(
            transaction,
            currency: currency,
            envelopes: widget.envelopes,
            showAccount: false,
            onTap: () => openTransaction(
              context,
              transaction,
              transactions: widget.transactions,
              envelopes: widget.envelopes,
              accounts: widget.accounts,
              onChanged: _load,
            ),
          );
        }
        final transfer = movement.transfer!;
        final outgoing = transfer.fromAccountId == widget.accountId;
        final other = widget.accounts.byId(
          outgoing ? transfer.toAccountId : transfer.fromAccountId,
        );
        final amount = formatMoney(transfer.amountMinor, currency);
        return UiTxRow(
          icon: UiIcons.arrowLeftRight,
          title: outgoing
              ? 'Transferencia a ${other?.name ?? 'otra cuenta'}'
              : 'Transferencia de ${other?.name ?? 'otra cuenta'}',
          subtitle: 'Sin sobre · ${timeLabel(transfer.occurredAt)}',
          amount: outgoing ? '−$amount' : amount,
          variant: outgoing ? UiTxRowVariant.expense : UiTxRowVariant.income,
          onTap: () => _delete(context, transfer),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, TransferData transfer) async {
    final confirmed = await confirmSheet(
      context,
      title: '¿Eliminar la transferencia?',
      detail: 'Los saldos de las dos cuentas vuelven a como estaban.',
      action: 'Eliminar',
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await widget.transfers.delete(widget.plans.activePlan!.id, transfer.id);
      await widget.accounts.load();
      if (context.mounted) showSaved(context, 'Transferencia eliminada');
    } on ApiFailure catch (failure) {
      if (!context.mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    }
  }
}

/// A transaction or a transfer of the account, ordered together in 14.
class _Movement {
  const _Movement(this.occurredAt, {this.transfer, this.transaction});

  final DateTime occurredAt;
  final TransferData? transfer;
  final TransactionData? transaction;
}
