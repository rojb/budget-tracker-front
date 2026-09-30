import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

enum UiChecklistState { done, pending, disabled }

/// One step of a checklist (06 "Primeros pasos"): a circle (lavender with a
/// check when done, outlined when pending, muted when not available yet), the
/// label, and a chevron when the step can be opened.
class UiChecklistRow extends StatelessWidget {
  const UiChecklistRow({
    required this.label,
    this.state = UiChecklistState.pending,
    this.onTap,
    super.key,
  });

  final String label;
  final UiChecklistState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final done = state == UiChecklistState.done;
    final disabled = state == UiChecklistState.disabled;
    final tappable = onTap != null && !disabled && !done;
    return UiHitTarget(
      onTap: tappable ? onTap : null,
      semanticLabel:
          '$label, ${done
              ? 'hecho'
              : disabled
              ? 'no disponible todavía'
              : 'pendiente'}',
      minWidth: 0,
      child: SizedBox(
        height: UiSizes.touchTarget,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: done ? UiColors.lavender : null,
                shape: BoxShape.circle,
                border: done
                    ? null
                    : Border.all(
                        color: disabled
                            ? UiColors.soft
                            : const Color(0xFFD0D0D0),
                        width: 1.5,
                      ),
              ),
              child: done
                  ? const Icon(UiIcons.check, size: 16, color: UiColors.ink)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UiTypography.custom(
                  17,
                  color: disabled ? UiColors.inkMuted : UiColors.ink,
                ),
              ),
            ),
            if (onTap != null && !done)
              Icon(
                UiIcons.chevronRight,
                size: 16,
                color: disabled ? UiColors.soft : UiColors.inkMuted,
              ),
          ],
        ),
      ),
    );
  }
}
