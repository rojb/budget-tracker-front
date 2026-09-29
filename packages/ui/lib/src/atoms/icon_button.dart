import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import 'hit_target.dart';

/// The seven IconButton variants of PRD-ux-spec.md section 8.
enum UiIconButtonVariant {
  white(UiColors.surface, UiColors.ink),
  black(UiColors.ink, UiColors.surface),
  lavender(UiColors.lavender, UiColors.ink),
  chartreuse(UiColors.chartreuse, UiColors.ink),
  soft(UiColors.soft, UiColors.ink),
  glass(UiColors.glass, UiColors.surface),
  danger(UiColors.dangerSoft, UiColors.danger);

  const UiIconButtonVariant(this.background, this.foreground);

  final Color background;
  final Color foreground;
}

/// Circular icon button. Diameter 48 to 56 (default 52).
class UiIconButton extends StatelessWidget {
  const UiIconButton({
    required this.icon,
    required this.onPressed,
    this.variant = UiIconButtonVariant.white,
    this.size = UiSizes.iconButton,
    this.iconSize = 20,
    this.semanticLabel,
    super.key,
  }) : assert(size >= 48 && size <= 64, 'IconButton size must be 48 to 64');

  final IconData icon;
  final VoidCallback? onPressed;
  final UiIconButtonVariant variant;
  final double size;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onPressed,
      semanticLabel: semanticLabel,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: variant.background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: iconSize, color: variant.foreground),
      ),
    );
  }
}
