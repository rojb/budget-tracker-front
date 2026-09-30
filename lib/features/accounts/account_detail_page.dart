import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/months.dart';
import '../plans/plans_controller.dart';
import 'accounts_controller.dart';
import 'accounts_page.dart';
import 'accounts_repository.dart';

/// Screen 14 Detalle de cuenta: balance, what entered and left this month and
/// the account's movements (the list arrives with add-transactions).
class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({
    required this.accountId,
    required this.accounts,
    required this.plans,
    super.key,
  });

  final String accountId;
  final AccountsController accounts;
  final PlansController plans;

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  AccountDetailData? _detail;
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
      final detail = await widget.accounts.detail(widget.accountId);
      if (mounted) setState(() => _detail = detail);
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
          UiCard(
            padding: const EdgeInsets.all(22),
            child: Text(
              'Todavía no hay movimientos',
              style: UiTypography.custom(16, color: UiColors.inkMuted),
            ),
          ),
        ],
      ],
    );
  }
}
