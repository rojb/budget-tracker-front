import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

/// Chip height scale: 44 (default) or 34 (compact preview chips).
enum UiChipSize {
  regular(UiSizes.chipHeight),
  compact(UiSizes.chipHeightCompact);

  const UiChipSize(this.height);

  final double height;
}

/// Pill chip. Default (surface), Selected (lavender), or with a leading check
/// or [icon] (the status filters of 02/04: "Sobregirados" with a warning).
/// [soft] uses the `bg` grey instead of white, for chips that sit on a white
/// card (06's template preview).
class UiChip extends StatelessWidget {
  const UiChip({
    required this.label,
    this.selected = false,
    this.soft = false,
    this.showCheck = false,
    this.icon,
    this.size = UiChipSize.regular,
    this.onPressed,
    super.key,
  });

  final String label;
  final bool selected;
  final bool soft;

  /// Leading check icon (the `DefaultIcon` variant).
  final bool showCheck;

  /// Optional leading icon; ignored when [showCheck] is set.
  final IconData? icon;
  final UiChipSize size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onPressed,
      semanticLabel: label,
      selected: selected,
      minWidth: 0,
      child: Container(
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: selected
              ? UiColors.lavender
              : (soft ? UiColors.bg : UiColors.surface),
          borderRadius: BorderRadius.circular(size.height / 2),
        ),
        child: Center(
          widthFactor: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCheck) ...[
                const Icon(UiIcons.check, size: 15, color: UiColors.ink),
                const SizedBox(width: 6),
              ] else if (icon != null) ...[
                Icon(icon, size: 18, color: UiColors.ink),
                const SizedBox(width: 8),
              ],
              ExcludeSemantics(
                child: Text(label, style: UiTypography.custom(15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
