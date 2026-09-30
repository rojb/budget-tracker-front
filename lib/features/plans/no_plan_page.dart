import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';

/// Signed in without any plan: the same two ways in as 34 Bienvenida.
class NoPlanPage extends StatelessWidget {
  const NoPlanPage({required this.onSignOut, super.key});

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
          children: [
            Text('Todavía no tenés un plan', style: UiTypography.headline),
            const SizedBox(height: 10),
            Text(
              'Creá uno para ordenar tu dinero, o unite al de otra persona.',
              style: UiTypography.custom(16, color: UiColors.inkMuted),
            ),
            const SizedBox(height: 28),
            UiOptionCard(
              icon: UiIcons.wallet,
              title: 'Crear mi plan',
              description:
                  'Tus cuentas, tus sobres, tu forma de ordenar el mes.',
              variant: UiOptionCardVariant.lavender,
              onPressed: () => context.push(AppRoutes.newPlan),
            ),
            const SizedBox(height: 12),
            UiOptionCard(
              icon: UiIcons.qrCode,
              title: 'Tengo un código',
              description: 'Unite a un plan que ya existe con su código o QR.',
              onPressed: () => context.push(AppRoutes.joinPlan),
            ),
            const SizedBox(height: 28),
            UiButton(
              label: 'Cerrar sesión',
              icon: UiIcons.logOut,
              variant: UiButtonVariant.secondary,
              onPressed: onSignOut,
            ),
          ],
        ),
      ),
    );
  }
}
