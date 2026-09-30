import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../plans/plans_controller.dart';
import 'accounts_controller.dart';
import 'accounts_repository.dart';

/// Screen 13 Cuentas: total balance of active accounts, one row per account
/// with its share, and the way to the archived ones (51).
class AccountsPage extends StatefulWidget {
  const AccountsPage({required this.accounts, required this.plans, super.key});

  final AccountsController accounts;
  final PlansController plans;

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController _search = TextEditingController();
  bool _searching = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _toggleSearch() => setState(() {
    _searching = !_searching;
    if (!_searching) _search.clear();
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([widget.accounts, widget.plans, _search]),
      builder: (context, _) {
        final accounts = widget.accounts;
        final currency = widget.plans.currency;
        final query = _search.text.trim().toLowerCase();
        final rows = accounts.active
            .where((a) => a.name.toLowerCase().contains(query))
            .toList();
        return RefreshIndicator(
          onRefresh: accounts.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _searching
                        ? UiTextField(
                            label: 'Buscar cuenta',
                            controller: _search,
                            textInputAction: TextInputAction.search,
                          )
                        : Text('Cuentas', style: UiTypography.custom(36)),
                  ),
                  const SizedBox(width: 10),
                  UiIconButton(
                    icon: _searching ? UiIcons.close : UiIcons.search,
                    semanticLabel: _searching ? 'Cerrar búsqueda' : 'Buscar',
                    onPressed: _toggleSearch,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              UiJoinedCard(
                primaryValue: formatMoney(accounts.totalMinor, currency),
                primaryLabel: 'Saldo total',
                secondaryValue: '${accounts.active.length}',
                secondaryLabel: 'Cuentas',
                addLabel: 'Nueva cuenta',
                onAdd: () => context.push(AppRoutes.newAccount),
              ),
              const SizedBox(height: 12),
              const UiInfoNote(
                text:
                    'Esto es lo que tenés, no lo que podés gastar. Lo gastable '
                    'está en tus sobres.',
              ),
              const SizedBox(height: 12),
              if (accounts.active.isEmpty && !accounts.loading)
                _Empty(onAdd: () => context.push(AppRoutes.newAccount))
              else
                for (final account in rows) ...[
                  UiCard(
                    child: UiAccountRow(
                      icon: account.kind.icon,
                      name: account.name,
                      subtitle: account.kind.label,
                      amount: formatMoney(account.balanceMinor, currency),
                      caption:
                          '${_percent(accounts.shareOf(account))} del total',
                      share: accounts.shareOf(account),
                      onTap: () =>
                          context.push(AppRoutes.accountDetail(account.id)),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              if (accounts.archived.isNotEmpty)
                UiCard(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: UiMenuRow(
                    icon: UiIcons.archive,
                    label: 'Archivadas · ${accounts.archived.length}',
                    onTap: () => context.push(AppRoutes.archivedAccounts),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  static String _percent(double share) => '${(share * 100).round()}%';
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Todavía no tenés cuentas', style: UiTypography.title),
          const SizedBox(height: 16),
          UiButton(
            label: 'Agregar cuenta',
            icon: UiIcons.plus,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}

/// "Banco · saldo inicial $ 300.000" subtitle used by 14.
String accountSubtitle(AccountData account, Currency currency) =>
    '${account.kind.label} · saldo inicial '
    '${formatMoney(account.openingBalanceMinor, currency)}';
