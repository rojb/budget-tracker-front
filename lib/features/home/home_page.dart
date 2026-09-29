import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'home_controller.dart';

/// Container widget: owns the controller and maps its state to `packages/ui`.
/// Placeholder for screens 01/02 with a minimal sign-out affordance.
class HomePage extends StatefulWidget {
  const HomePage({required this.controllerFactory, super.key});

  final HomeController Function() controllerFactory;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller = widget.controllerFactory();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(_controller.greeting, style: UiTypography.headline),
                const SizedBox(height: 8),
                if (_controller.email != null)
                  Text(_controller.email!, style: UiTypography.caption),
                const SizedBox(height: 12),
                Text(
                  'Inicio (pantallas 01/02) llega con add-plans-and-accounts.',
                  style: UiTypography.custom(16, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 32),
                UiButton(
                  label: 'Cerrar sesión',
                  icon: UiIcons.logOut,
                  variant: UiButtonVariant.secondary,
                  onPressed: _controller.logout,
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
