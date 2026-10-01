import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Envelope card of the carousel of 03 Asignar dinero: the icon in a circle,
/// the share of the need the amount covers ("100%"), the name, its available
/// amount ("−$ 6.200 disponible") and a caption with what it would become
/// ("Sobregirado · quedaría en $ 0"). Lavender when [selected], white
/// otherwise; the whole card is the tap target.
class UiAssignCard extends StatelessWidget {
  const UiAssignCard({
    required this.icon,
    required this.name,
    required this.available,
    this.caption,
    this.percent,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String name;

  /// "−$ 6.200 disponible".
  final String available;
  final String? caption;

  /// "100%", or nothing when the envelope has no need to cover.
  final String? percent;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onTap,
      selected: selected,
      semanticLabel: [name, available, ?caption, ?percent].join(', '),
      minWidth: 0,
      child: ExcludeSemantics(
        child: Container(
          height: 180,
          padding: const EdgeInsets.fromLTRB(18, 18, 22, 18),
          decoration: BoxDecoration(
            color: selected ? UiColors.lavender : UiColors.surface,
            borderRadius: BorderRadius.circular(34),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? UiColors.trayFill : UiColors.bg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 22, color: UiColors.ink),
                  ),
                  const Spacer(),
                  if (percent != null)
                    Text(percent!, style: UiTypography.custom(22)),
                ],
              ),
              const Spacer(),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UiTypography.custom(22),
              ),
              const SizedBox(height: 2),
              Text(
                available,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UiTypography.custom(15),
              ),
              if (caption != null) ...[
                const SizedBox(height: 4),
                Text(
                  caption!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(13, color: UiColors.inkMuted),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
