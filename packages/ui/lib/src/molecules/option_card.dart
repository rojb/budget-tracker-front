import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

enum UiOptionCardVariant { lavender, white }

/// Large choice card of screen 34: a 52 dp icon circle and a chevron on top,
/// then a title and a description. Lavender highlights the recommended option;
/// White is the alternative. The whole card is the tap target.
class UiOptionCard extends StatelessWidget {
  const UiOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
    this.variant = UiOptionCardVariant.white,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onPressed;
  final UiOptionCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final lavender = variant == UiOptionCardVariant.lavender;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: '$title. $description',
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: lavender ? UiColors.lavender : UiColors.surface,
              borderRadius: BorderRadius.circular(UiRadius.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: lavender ? UiColors.surface : UiColors.bg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 24, color: UiColors.ink),
                    ),
                    const Spacer(),
                    const Icon(
                      UiIcons.chevronRight,
                      size: 20,
                      color: UiColors.inkMuted,
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: 30),
                Text(title, style: UiTypography.title),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: UiTypography.custom(15, color: UiColors.inkMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
