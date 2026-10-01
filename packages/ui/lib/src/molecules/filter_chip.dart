import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Removable chip of an active filter on 10 Movimientos: a leading icon, the
/// label ("1 – 30 sep", "18:00 – 23:59", "Coto") and an `x` that removes the
/// filter. White pill, 44 dp high.
class UiFilterChip extends StatelessWidget {
  const UiFilterChip({
    required this.icon,
    required this.label,
    required this.onRemove,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UiSizes.chipHeight,
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: UiColors.surface,
        borderRadius: BorderRadius.circular(UiSizes.chipHeight / 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(child: Icon(icon, size: 18, color: UiColors.ink)),
          const SizedBox(width: 8),
          Flexible(
            child: ExcludeSemantics(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UiTypography.custom(15),
              ),
            ),
          ),
          UiHitTarget(
            onTap: onRemove,
            semanticLabel: 'Quitar filtro $label',
            minWidth: 40,
            child: const ExcludeSemantics(
              child: Icon(UiIcons.close, size: 18, color: UiColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}
