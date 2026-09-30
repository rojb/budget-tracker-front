import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// One of the two "¿A dónde va?" choices of 09 Registrar ingreso: icon circle,
/// title, description and, at the end, a dark check circle when [selected]
/// (the card turns lavender) or an empty radio otherwise (white card). The
/// whole card is the tap target.
class UiChoiceCard extends StatelessWidget {
  const UiChoiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      enabled: onTap != null,
      label: '$title. $description',
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 76),
            padding: const EdgeInsets.fromLTRB(14, 14, 18, 14),
            decoration: BoxDecoration(
              color: selected ? UiColors.lavender : UiColors.surface,
              borderRadius: BorderRadius.circular(UiRadius.card),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? UiColors.surface.withValues(alpha: 0.6)
                        : UiColors.bg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 22, color: UiColors.ink),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: UiTypography.custom(21),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: UiTypography.custom(
                          15,
                          color: UiColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? UiColors.ink : UiColors.soft,
                    shape: BoxShape.circle,
                    border: selected
                        ? null
                        : Border.all(
                            color: const Color(0xFFD0D0D0),
                            width: 1.5,
                          ),
                  ),
                  child: selected
                      ? const Icon(
                          UiIcons.check,
                          size: 16,
                          color: UiColors.surface,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
