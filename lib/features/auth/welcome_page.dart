import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/router.dart';
import 'auth_controller.dart';

/// Screen 34 Bienvenida, shown once right after sign-up.
class WelcomePage extends StatelessWidget {
  const WelcomePage({required this.auth, super.key});

  final AuthController auth;

  void _go(BuildContext context, String route) {
    // Clear the flag before navigating so the router keeps the chosen route.
    auth.consumeWelcome();
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 44, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                // Narrower than the screen so the title wraps in two lines like the design.
                padding: const EdgeInsets.only(right: 90),
                child: Text(
                  '¿Cómo querés empezar?',
                  style: UiTypography.headline.copyWith(height: 1.05),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Elegí si vas a armar tu plan desde cero o alguien ya te invitó a uno.',
                style: UiTypography.custom(15, color: UiColors.inkMuted),
              ),
              const SizedBox(height: 28),
              UiOptionCard(
                icon: UiIcons.sparkles,
                title: 'Crear mi plan',
                description:
                    'Armá tu plan desde cero, con tus cuentas y tus sobres.',
                variant: UiOptionCardVariant.lavender,
                onPressed: () => _go(context, AppRoutes.newPlan),
              ),
              const SizedBox(height: 20),
              UiOptionCard(
                icon: UiIcons.qrCode,
                title: 'Tengo un código',
                description: 'Alguien ya te invitó a un plan compartido. Ingresá el código o escaneá el QR.',
                onPressed: () => _go(context, AppRoutes.joinPlan),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  const SizedBox(width: 4),
                  const Icon(
                    UiIcons.camera,
                    size: 20,
                    color: UiColors.inkMuted,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'El código QR también funciona con la cámara del teléfono.',
                      style: UiTypography.custom(13, color: UiColors.inkMuted),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
