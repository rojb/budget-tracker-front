import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';

/// Signed-in tabs: Inicio · Plan · "+" · Movimientos · Cuentas. The
/// `UiNavCluster` is a fixed sibling of the scrolling content
/// (PRD-ux-spec.md 6.1 rule 3); each tab keeps its own navigation stack.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

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
