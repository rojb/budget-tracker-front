import 'package:flutter/material.dart' show CircularProgressIndicator;
import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

enum UiButtonVariant { primary, secondary, white, danger }

/// Full-width pill button: Primary (chartreuse, 56), Secondary (bg, 52), White
/// (surface, 56, e.g. "Cancelar" on a confirmation sheet) or Danger (solid
/// `danger` with white text, 56; PRD-ux-spec.md 6.1 rule 2).
class UiButton extends StatelessWidget {
  const UiButton({
    required this.label,
    required this.onPressed,
    this.variant = UiButtonVariant.primary,
    this.icon,
    this.loading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final UiButtonVariant variant;
  final IconData? icon;

  /// Shows a spinner instead of the icon and label, and ignores taps.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final large = variant != UiButtonVariant.secondary;
    final height = large
        ? UiSizes.buttonPrimaryHeight
        : UiSizes.buttonSecondaryHeight;
    // Without a handler the button is disabled: muted grey, never the live
    // chartreuse, so a dead tap does not look alive.
    final disabled = onPressed == null && !loading;
    final foreground = disabled
        ? UiColors.inkMuted
        : (variant == UiButtonVariant.danger ? UiColors.surface : UiColors.ink);
    final background = disabled
        ? UiColors.soft
        : switch (variant) {
            UiButtonVariant.primary => UiColors.chartreuse,
            UiButtonVariant.secondary => UiColors.bg,
            UiButtonVariant.white => UiColors.surface,
            UiButtonVariant.danger => UiColors.danger,
          };
    final style = UiTypography.custom(
      large ? 16 : 15,
      weight: 500,
      color: foreground,
    );
    return UiHitTarget(
      onTap: loading ? null : onPressed,
      semanticLabel: loading ? '$label, cargando' : label,
      minWidth: 0,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: loading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foreground,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: foreground),
                    const SizedBox(width: 8),
                  ],
                  ExcludeSemantics(child: Text(label, style: style)),
                ],
              ),
      ),
    );
  }
}
