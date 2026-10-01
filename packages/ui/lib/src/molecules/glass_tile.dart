import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'goal_summary.dart';

/// Tile of 05 Detalle de meta ("Últimos aportes", "Plan de aportes", "Mover
/// dinero", "Ajustar objetivo"): an icon circle and a diagonal arrow circle on
/// top and the [label] under them, on a [UiGlassPanel]. The whole tile is
/// tappable (at least 48 dp). With [onPhoto] false it draws `ink` content on
/// a light panel.
class UiGlassTile extends StatelessWidget {
  const UiGlassTile({
    required this.icon,
    required this.label,
    this.onPhoto = true,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool onPhoto;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = onPhoto ? UiColors.surface : UiColors.ink;
    final circle = onPhoto ? UiColors.glass : UiColors.surface.withAlpha(150);
    Widget disc(IconData glyph) => Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(color: circle, shape: BoxShape.circle),
      child: Icon(glyph, size: 22, color: text),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      label: label,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: UiSizes.touchTarget),
            child: UiGlassPanel(
              onPhoto: onPhoto,
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                height: 96,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [disc(icon), disc(UiIcons.arrowUpRight)],
                    ),
                    const Spacer(),
                    Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(22, weight: 300, color: text),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
