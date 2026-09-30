import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Group header of the plan (PRD-ux-spec.md section 8, "Los tres estilos de
/// etiqueta de grupo", style 1; 02, 04, 33): the group name (20 / 400), its
/// subtotal ("$ 85.350 disponible", 13 `ink-muted`) and a 32 dp "+" that
/// creates an envelope in the group. The "+" keeps a 48 dp hit area.
class UiGroupHeader extends StatelessWidget {
  const UiGroupHeader({
    required this.name,
    required this.subtitle,
    this.onAdd,
    this.addLabel = 'Agregar sobre',
    super.key,
  });

  final String name;

  /// Formatted subtotal with its word, e.g. "$ 85.350 disponible".
  final String subtitle;

  /// Shows the "+" when set.
  final VoidCallback? onAdd;
  final String addLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              label: '$name, $subtitle',
              child: ExcludeSemantics(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ExcludeSemantics(
            child: Text(
              subtitle,
              style: UiTypography.custom(13, color: UiColors.inkMuted),
            ),
          ),
          if (onAdd != null)
            UiHitTarget(
              onTap: onAdd,
              semanticLabel: '$addLabel en $name',
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: UiColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(UiIcons.plus, size: 18, color: UiColors.ink),
              ),
            )
          else
            const SizedBox(height: 48),
        ],
      ),
    );
  }
}
