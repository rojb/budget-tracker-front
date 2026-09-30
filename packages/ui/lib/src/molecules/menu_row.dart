import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Menu entry of 39 Menú de cuenta: icon in a soft circle, label and chevron.
/// [destructive] draws the icon circle and label in `danger` without a
/// chevron ("Cerrar sesión").
class UiMenuRow extends StatelessWidget {
  const UiMenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? UiColors.danger : UiColors.ink;
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      minWidth: 0,
      child: SizedBox(
        height: 68,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: destructive ? UiColors.dangerSoft : UiColors.bg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label, style: UiTypography.custom(18, color: color)),
            ),
            if (!destructive)
              const Icon(
                UiIcons.chevronRight,
                size: 18,
                color: UiColors.inkMuted,
              ),
          ],
        ),
      ),
    );
  }
}
