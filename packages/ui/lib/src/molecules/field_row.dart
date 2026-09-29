import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Editable-value row: muted label at the start, value plus chevron at the end.
/// The chevron is always shown (PRD-ux-spec.md 6.1 rule 4).
class UiFieldRow extends StatelessWidget {
  const UiFieldRow({
    required this.label,
    required this.value,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: '$label: $value',
      minWidth: 0,
      child: SizedBox(
        height: UiSizes.touchTarget,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: UiTypography.custom(14, color: UiColors.inkMuted),
              ),
            ),
            const SizedBox(width: 10),
            Text(value, style: UiTypography.custom(15, weight: 500)),
            const SizedBox(width: 4),
            const Icon(UiIcons.chevronRight, size: 14, color: UiColors.inkMuted),
          ],
        ),
      ),
    );
  }
}
