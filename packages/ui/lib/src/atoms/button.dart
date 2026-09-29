import 'package:flutter/material.dart' show CircularProgressIndicator;
import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

enum UiButtonVariant { primary, secondary }

/// Full-width pill button: Primary (chartreuse, 56) or Secondary (bg, 52).
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
    final primary = variant == UiButtonVariant.primary;
    final height = primary
        ? UiSizes.buttonPrimaryHeight
        : UiSizes.buttonSecondaryHeight;
    final style = UiTypography.custom(primary ? 16 : 15, weight: 500);
    return UiHitTarget(
      onTap: loading ? null : onPressed,
      semanticLabel: loading ? '$label, cargando' : label,
      minWidth: 0,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primary ? UiColors.chartreuse : UiColors.bg,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: UiColors.ink,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: UiColors.ink),
                    const SizedBox(width: 8),
                  ],
                  ExcludeSemantics(child: Text(label, style: style)),
                ],
              ),
      ),
    );
  }
}
