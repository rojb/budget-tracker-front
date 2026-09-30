import 'package:flutter/widgets.dart';

import '../atoms/avatar.dart';
import '../atoms/hit_target.dart';
import '../tokens/icons.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Member row of 16: avatar, name and email, and the role as a pill
/// ("Titular", "Puede editar", "Solo lectura"). With [onRoleTap] the pill gets
/// a chevron and opens the role sheet (the owner managing other members).
class UiMemberRow extends StatelessWidget {
  const UiMemberRow({
    required this.initials,
    required this.name,
    required this.email,
    required this.role,
    this.avatarColor = UiColors.lavender,
    this.onRoleTap,
    super.key,
  });

  final String initials;
  final String name;
  final String email;
  final String role;
  final Color avatarColor;
  final VoidCallback? onRoleTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '$name, $email, $role',
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            ExcludeSemantics(
              child: UiAvatar(initials: initials, color: avatarColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: ExcludeSemantics(
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
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(13, color: UiColors.inkMuted),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (onRoleTap == null)
              ExcludeSemantics(child: _pill(false))
            else
              UiHitTarget(
                onTap: onRoleTap,
                semanticLabel: 'Rol de $name: $role, cambiar',
                child: ExcludeSemantics(child: _pill(true)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _pill(bool tappable) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: UiColors.bg,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(role, style: UiTypography.custom(14)),
          if (tappable) ...[
            const SizedBox(width: 6),
            const Icon(UiIcons.chevronDown, size: 14, color: UiColors.ink),
          ],
        ],
      ),
    );
  }
}
