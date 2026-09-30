import 'package:flutter/widgets.dart';

import '../atoms/avatar.dart';
import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Payee row of 15 Beneficiarios: initials avatar, name, subtitle
/// ("Supermercado · 14 movimientos") and a chevron. Unlike the amount rows it
/// keeps the chevron: its right column has no figure (PRD-ux-spec.md 8).
class UiPayeeRow extends StatelessWidget {
  const UiPayeeRow({
    required this.initials,
    required this.name,
    required this.subtitle,
    this.highlighted = false,
    this.onTap,
    super.key,
  });

  final String initials;
  final String name;
  final String subtitle;

  /// Lavender avatar (the first row of the render); soft grey otherwise.
  final bool highlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: '$name, $subtitle',
      minWidth: 0,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              UiAvatar(
                initials: initials,
                color: highlighted ? UiColors.lavender : UiColors.bg,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(14, color: UiColors.inkMuted),
                    ),
                  ],
                ),
              ),
              const Icon(
                UiIcons.chevronRight,
                size: 18,
                color: UiColors.inkMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
