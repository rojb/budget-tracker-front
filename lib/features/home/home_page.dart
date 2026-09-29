import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'home_controller.dart';

/// Container widget: owns the controller and maps its state to `packages/ui`.
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
        child: Center(
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => Text(
              _controller.message,
              style: UiTypography.headline,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
