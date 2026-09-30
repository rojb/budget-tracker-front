import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../auth/auth_controller.dart';

/// Screen 39 Menú de cuenta: bottom sheet opened from the avatar of 01.
class AccountMenu {
  const AccountMenu(this._auth);

  final AuthController _auth;

  Future<void> show(BuildContext context) {
    final user = _auth.user;
    final name = user?.name ?? '';
    final initials = name.isEmpty
        ? '?'
        : name.substring(0, name.length < 2 ? 1 : 2).toUpperCase();
    return showUiSheet<void>(
      context,
      builder: (sheetContext) {
        void go(String route) {
          Navigator.of(sheetContext).pop();
          context.push(route);
        }

        return UiSheet(
          header: Row(
            children: [
              UiAvatar(initials: initials),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: UiTypography.custom(18)),
                    if (user != null)
                      Text(user.email, style: UiTypography.caption),
                  ],
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UiCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                child: Column(
                  children: [
                    UiMenuRow(
                      icon: UiIcons.layers,
                      label: 'Planes y miembros',
                      onTap: () => go(AppRoutes.plans),
                    ),
                    UiMenuRow(
                      icon: UiIcons.contact,
                      label: 'Beneficiarios',
                      onTap: () => go(AppRoutes.payees),
                    ),
                    UiMenuRow(
                      icon: UiIcons.keyRound,
                      label: 'Unirme con código',
                      onTap: () => go(AppRoutes.joinPlan),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: UiMenuRow(
                  icon: UiIcons.logOut,
                  label: 'Cerrar sesión',
                  destructive: true,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _auth.logout();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
