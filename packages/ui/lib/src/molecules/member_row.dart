import 'package:flutter/widgets.dart';

import '../atoms/avatar.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Member row of 16: avatar, name and email, and the role as a pill
/// ("Dueña", "Puede editar", "Solo lectura"). Read-only; role changes arrive
/// with plan sharing.
class UiMemberRow extends StatelessWidget {
  const UiMemberRow({
    required this.initials,
    required this.name,
    required this.email,
    required this.role,
    this.avatarColor = UiColors.lavender,
    super.key,
  });

  final String initials;
  final String name;
  final String email;
  final String role;
  final Color avatarColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$name, $email, $role',
      child: ExcludeSemantics(
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              UiAvatar(initials: initials, color: avatarColor),
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
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(13, color: UiColors.inkMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: UiColors.bg,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Text(role, style: UiTypography.custom(14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
