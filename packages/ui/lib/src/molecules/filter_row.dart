import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Beneficiario / Sobre / Cuenta row of 11 Filtrar movimientos: leading icon,
/// label, the current choice in muted text ("Todos" until one is picked) and a
/// chevron-down. Its own white pill, 52 dp high.
class UiFilterRow extends StatelessWidget {
  const UiFilterRow({
    required this.icon,
    required this.label,
    required this.value,
    this.active = false,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;

  /// True when a choice is set: the value is drawn in `ink` instead of muted.
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: '$label: $value',
      minWidth: 0,
      child: ExcludeSemantics(
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: UiColors.surface,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: UiColors.ink),
              const SizedBox(width: 12),
              Text(label, style: UiTypography.custom(17)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: UiTypography.custom(
                    16,
                    color: active ? UiColors.ink : UiColors.inkMuted,
                    weight: active ? 500 : 400,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                UiIcons.chevronDown,
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
