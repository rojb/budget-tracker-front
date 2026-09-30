import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../shell/account_menu_sheet.dart';
import 'home_controller.dart';

/// Screen 01 Inicio, minimal shell: the avatar opens 39 Menú de cuenta.
/// The goal carousel and the month card are added by later changes.
class HomePage extends StatefulWidget {
  const HomePage({
    required this.controllerFactory,
    required this.menu,
    super.key,
  });

  final HomeController Function() controllerFactory;
  final AccountMenu menu;

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
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Row(
            children: [
              Semantics(
                button: true,
                label: 'Menú de cuenta',
                child: GestureDetector(
                  onTap: () => widget.menu.show(context),
                  child: ExcludeSemantics(
                    child: UiAvatar(initials: _controller.initials),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(_controller.greeting, style: UiTypography.headline),
          if (_controller.planName != null) ...[
            const SizedBox(height: 6),
            Text(_controller.planName!, style: UiTypography.caption),
          ],
          const SizedBox(height: 24),
          const UiInfoNote(
            text:
                'Tus metas y el resumen del mes aparecen acá cuando crees tus '
                'sobres.',
          ),
        ],
      ),
    );
  }
}
