import 'package:flutter/widgets.dart';

import '../atoms/avatar.dart';
import '../atoms/hit_target.dart';
import '../atoms/selection_mark.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

enum UiPayeeRowVariant {
  /// 15 Beneficiarios: a chevron when the row can be opened.
  list,

  /// 26 Elegir beneficiario: lavender avatar and the selection mark
  /// (lavender check, or an empty radio) instead of the chevron.
  selectable,
}

/// Payee row of 15 Beneficiarios: initials avatar, name, subtitle
/// ("Supermercado · 14 movimientos") and a chevron when it can be opened. Unlike the amount rows it
/// keeps the chevron: its right column has no figure (PRD-ux-spec.md 8). The [UiPayeeRowVariant.selectable]
/// variant is the row of the picker 26.
class UiPayeeRow extends StatelessWidget {
  const UiPayeeRow({
    required this.initials,
    required this.name,
    required this.subtitle,
    this.highlighted = false,
    this.variant = UiPayeeRowVariant.list,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final String initials;
  final String name;
  final String subtitle;

  /// Lavender avatar (the first row of the render); soft grey otherwise.
  final bool highlighted;
  final UiPayeeRowVariant variant;

  /// Selectable variant: the lavender check instead of the empty radio.
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final selectable = variant == UiPayeeRowVariant.selectable;
    final content = ExcludeSemantics(
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            UiAvatar(
              initials: initials,
              color: highlighted || selectable
                  ? UiColors.lavender
                  : UiColors.bg,
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
            if (selectable)
              UiSelectionMark(selected: selected)
            else if (onTap != null)
              const Icon(
                UiIcons.chevronRight,
                size: 18,
                color: UiColors.inkMuted,
              ),
          ],
        ),
      ),
    );
    // Without [onTap] (47) it is a labelled group, not a disabled button.
    if (onTap == null) {
      return Semantics(
        container: true,
        label: '$name, $subtitle',
        child: content,
      );
    }
    return UiHitTarget(
      onTap: onTap,
      selected: selectable ? selected : null,
      semanticLabel: '$name, $subtitle',
      minWidth: 0,
      child: content,
    );
  }
}
