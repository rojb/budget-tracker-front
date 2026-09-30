import 'package:flutter/widgets.dart';

import '../atoms/avatar.dart';
import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Plan row of 16 Planes y miembros. Active: lavender card with a black check.
/// Inactive: white card with a chevron. Leading: an icon circle, or the
/// members' initials overlapped. Never shows amounts (PRD-ux-spec.md 7 Moneda).
class UiPlanRow extends StatelessWidget {
  const UiPlanRow({
    required this.title,
    required this.subtitle,
    this.active = false,
    this.icon,
    this.initials = const [],
    this.onTap,
    super.key,
  });

  final String title;

  /// e.g. "Solo vos · pesos ($)" or "Compartido · 2 miembros · pesos ($)".
  final String subtitle;
  final bool active;

  /// Leading icon; when null the first two [initials] are shown overlapped.
  final IconData? icon;
  final List<String> initials;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final label = '$title, $subtitle${active ? ', plan activo' : ''}';
    final card = ExcludeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: active ? UiColors.lavender : UiColors.surface,
          borderRadius: BorderRadius.circular(UiRadius.card),
        ),
        child: Row(
          children: [
            _leading(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: UiTypography.custom(18),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: onTap == null ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: UiTypography.custom(14, color: UiColors.inkMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (active)
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: UiColors.ink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  UiIcons.check,
                  size: 18,
                  color: UiColors.surface,
                ),
              )
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
    // Without [onTap] (45's preview) it is a labelled group, not a disabled button.
    if (onTap == null) {
      return Semantics(container: true, label: label, child: card);
    }
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      selected: active,
      minWidth: 0,
      child: card,
    );
  }

  Widget _leading() {
    if (icon != null || initials.isEmpty) {
      return Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? UiColors.surface.withValues(alpha: 0.6) : UiColors.bg,
          shape: BoxShape.circle,
        ),
        child: Icon(icon ?? UiIcons.wallet, size: 22, color: UiColors.ink),
      );
    }
    if (initials.length == 1) {
      return UiAvatar(initials: initials.first);
    }
    return SizedBox(
      width: 84,
      height: 52,
      child: Stack(
        children: [
          Positioned(
            left: 32,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: UiColors.surface, width: 2),
              ),
              child: UiAvatar(
                initials: initials[1],
                size: 48,
                color: UiColors.bg,
              ),
            ),
          ),
          UiAvatar(initials: initials.first),
        ],
      ),
    );
  }
}
