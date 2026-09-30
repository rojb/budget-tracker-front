import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import '../common/months.dart';
import '../plans/plans_controller.dart';
import 'accounts_controller.dart';
import 'accounts_repository.dart';

/// Screen 51 Cuentas archivadas: archived accounts with "Restaurar".
class ArchivedAccountsPage extends StatelessWidget {
  const ArchivedAccountsPage({
    required this.accounts,
    required this.plans,
    super.key,
  });

  final AccountsController accounts;
  final PlansController plans;

  Future<void> _restore(BuildContext context, AccountData account) async {
    try {
      await accounts.restore(account.id);
      if (context.mounted) {
        showUiToast(
          context,
          variant: UiToastVariant.success,
          title: 'Cuenta restaurada',
          detail: '${account.name} vuelve a sumar al saldo total.',
        );
      }
    } on ApiFailure catch (failure) {
      if (!context.mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: accounts,
          builder: (context, _) => ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: UiIconButton(
                  icon: UiIcons.chevronLeft,
                  semanticLabel: 'Volver',
                  onPressed: () => context.pop(),
                ),
              ),
              const SizedBox(height: 22),
              Text('Cuentas archivadas', style: UiTypography.custom(36)),
              const SizedBox(height: 16),
              const UiInfoNote(
                text: 'No suman al saldo total. Sus movimientos se conservan.',
              ),
              const SizedBox(height: 12),
              if (accounts.archived.isEmpty)
                UiCard(
                  padding: const EdgeInsets.all(22),
                  child: Text(
                    'No tenés cuentas archivadas.',
                    style: UiTypography.custom(16, color: UiColors.inkMuted),
                  ),
                ),
              for (final account in accounts.archived) ...[
                UiCard(
                  child: UiAccountRow(
                    variant: UiAccountRowVariant.archived,
                    icon: account.kind.icon,
                    name: account.name,
                    subtitle: account.archivedAt == null
                        ? account.kind.label
                        : '${account.kind.label} · archivada el '
                              '${dayMonthShort(account.archivedAt!.toLocal())}',
                    amount: formatMoney(account.balanceMinor, plans.currency),
                    trailing: UiChip(
                      label: 'Restaurar',
                      selected: true,
                      size: UiChipSize.compact,
                      onPressed: () => _restore(context, account),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
