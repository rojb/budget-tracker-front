import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../accounts/accounts_controller.dart';
import '../envelopes/envelopes_controller.dart';
import '../transactions/transactions_controller.dart';

/// Signed-in tabs: Inicio · Plan · "+" · Movimientos · Cuentas. The
/// `UiNavCluster` is a fixed sibling of the scrolling content
/// (PRD-ux-spec.md 6.1 rule 3); each tab keeps its own navigation stack.
///
/// It also keeps the shared figures fresh (F-05): when the app comes back to the
/// foreground after [staleAfter] or more, it reloads envelopes, accounts and
/// movements. A shorter absence reloads nothing. The controllers keep the old
/// data while loading and when a reload fails, so being offline changes nothing
/// on screen, and the viewed month of the plan is kept by the envelopes.
class AppShell extends StatefulWidget {
  const AppShell({
    required this.navigationShell,
    required this.envelopes,
    required this.accounts,
    required this.transactions,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final EnvelopesController envelopes;
  final AccountsController accounts;
  final TransactionsController transactions;

  /// How long the app must have been away before a resume reloads.
  static const Duration staleAfter = Duration(seconds: 60);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with WidgetsBindingObserver {
  DateTime? _leftAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // `inactive` also fires for a system dialog; only a real background counts.
        _leftAt ??= DateTime.now();
      case AppLifecycleState.resumed:
        final left = _leftAt;
        _leftAt = null;
        if (left != null &&
            DateTime.now().difference(left) >= AppShell.staleAfter) {
          widget.envelopes.load();
          widget.accounts.load();
          widget.transactions.refresh();
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  StatefulNavigationShell get navigationShell => widget.navigationShell;

  static const List<UiNavTab> _tabs = [
    UiNavTab.home,
    UiNavTab.plan,
    UiNavTab.transactions,
    UiNavTab.accounts,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(bottom: false, child: navigationShell),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Center(
            heightFactor: 1,
            child: UiNavCluster(
              activeTab: _tabs[navigationShell.currentIndex],
              onTabSelected: (tab) => navigationShell.goBranch(
                _tabs.indexOf(tab),
                initialLocation: tab == _tabs[navigationShell.currentIndex],
              ),
              onAddPressed: () => context.push(AppRoutes.newTransaction),
            ),
          ),
        ),
      ),
    );
  }
}
