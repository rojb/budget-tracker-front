import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

enum UiInfoNoteVariant { plain, lavender }

/// Read-only note. Plain: white card with an info icon and muted text (13
/// Cuentas, 51 Cuentas archivadas). Lavender: a consequence note with the icon
/// in a white circle, a title and a detail (48 Archivar cuenta). Text without a
/// container would read as a label; the card marks it as an explanation.
class UiInfoNote extends StatelessWidget {
  const UiInfoNote({
    required this.text,
    this.title,
    this.icon = UiIcons.info,
    this.variant = UiInfoNoteVariant.plain,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// Muted body text (the detail line in the lavender variant).
  final String text;

  /// Optional first line in `ink` (lavender variant).
  final String? title;
  final IconData icon;
  final UiInfoNoteVariant variant;

  /// Trailing pill action, shown when both are set.
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final lavender = variant == UiInfoNoteVariant.lavender;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: lavender ? 16 : 18,
        vertical: lavender ? 14 : 14,
      ),
      decoration: BoxDecoration(
        color: lavender ? UiColors.lavender : UiColors.surface,
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: Row(
        crossAxisAlignment: lavender
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (lavender)
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: UiColors.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: UiColors.ink),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(icon, size: 18, color: UiColors.ink),
            ),
          SizedBox(width: lavender ? 14 : 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) Text(title!, style: UiTypography.custom(15)),
                Text(
                  text,
                  style: UiTypography.custom(
                    13,
                    color: lavender ? UiColors.ink : UiColors.inkMuted,
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(width: 8),
            UiHitTarget(
              onTap: onAction,
              semanticLabel: actionLabel!,
              minWidth: 0,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: UiColors.ink,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: ExcludeSemantics(
                  child: Text(
                    actionLabel!,
                    style: UiTypography.custom(15, color: UiColors.surface),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
