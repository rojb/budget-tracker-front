import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';

/// Full-bleed backdrop of 05 Detalle de meta: the goal's photo under a scrim
/// so the white text of the glass panels stays legible (PRD-ux-spec.md
/// section 7), or, without a photo, the lavender tint with the goal's [icon].
/// It fills its parent; place it at the bottom of a `Stack`.
///
/// Over the tint the panels must draw `ink` text instead of white (the
/// forbidden pair white on lavender): the screen passes `onPhoto: false` to
/// them when [image] is null. A photo that fails to load falls back to a dark
/// `ink` backdrop, where white text is still legible.
class UiGoalBackdrop extends StatelessWidget {
  const UiGoalBackdrop({required this.icon, this.image, super.key});

  final IconData icon;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return ExcludeSemantics(
        child: _Tint(icon: icon, color: UiColors.lavender),
      );
    }
    return ExcludeSemantics(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: image!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _Tint(
              icon: icon,
              color: UiColors.ink,
              iconColor: UiColors.lavender,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.35, 1],
                colors: [
                  UiColors.ink.withAlpha(110),
                  UiColors.ink.withAlpha(30),
                  UiColors.ink.withAlpha(170),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tint extends StatelessWidget {
  const _Tint({required this.icon, required this.color, this.iconColor});

  final IconData icon;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Align(
        alignment: const Alignment(0, -0.35),
        child: Icon(
          icon,
          size: 150,
          color: (iconColor ?? UiColors.ink).withAlpha(50),
        ),
      ),
    );
  }
}
