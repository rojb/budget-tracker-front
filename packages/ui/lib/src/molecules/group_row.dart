import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

enum UiGroupRowVariant {
  /// 32 Grupos: drag handle, name, count and a [UiGroupRow.trailing] slot for
  /// the pencil and trash buttons.
  manage,

  /// 52 Elegir grupo: layers circle, name, count and a radio (a lavender check
  /// when [UiGroupRow.selected]).
  selectable,

  /// 44 Eliminar grupo: layers circle, name and count, nothing to tap.
  summary,
}

/// Group row (PRD-ux-spec.md section 8, "Los tres estilos de etiqueta de
/// grupo", style 3): name 16 / 500 with the envelope count as a 13 `ink-muted`
/// subtitle ("4 sobres"). It has no background, so the screen decides whether
/// it sits in its own card (32, 44) or in a shared one (52).
class UiGroupRow extends StatelessWidget {
  const UiGroupRow({
    required this.name,
    required this.subtitle,
    this.variant = UiGroupRowVariant.manage,
    this.selected = false,
    this.handle,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String name;

  /// Envelope count, e.g. "4 sobres".
  final String subtitle;
  final UiGroupRowVariant variant;
  final bool selected;

  /// Drag handle of the manage variant; the screen wraps [grip] in the
  /// drag-start listener of its reorderable list. Defaults to a plain [grip].
  final Widget? handle;

  /// Row actions of the manage variant (pencil and trash buttons).
  final Widget? trailing;
  final VoidCallback? onTap;

  /// The six-dot grip icon of the manage variant.
  static Widget grip() => const SizedBox(
    width: 40,
    height: 48,
    child: Icon(UiIcons.grip, size: 22, color: UiColors.inkMuted),
  );

  @override
  Widget build(BuildContext context) {
    final text = Expanded(
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: UiTypography.custom(17, weight: 500),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: UiTypography.custom(13, color: UiColors.inkMuted),
            ),
          ],
        ),
      ),
    );
    final manage = variant == UiGroupRowVariant.manage;
    final row = Row(
      children: [
        if (manage)
          handle ?? grip()
        else
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: UiColors.bg,
              shape: BoxShape.circle,
            ),
            child: const Icon(UiIcons.layers, size: 22, color: UiColors.ink),
          ),
        SizedBox(width: manage ? 4 : 14),
        text,
        if (manage && trailing != null) trailing!,
        if (variant == UiGroupRowVariant.selectable) _Radio(selected: selected),
      ],
    );
    final content = SizedBox(height: manage ? 66 : 64, child: row);
    final label = '$name, $subtitle';
    if (onTap == null) {
      return Semantics(container: true, label: label, child: content);
    }
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      selected: variant == UiGroupRowVariant.selectable ? selected : null,
      minWidth: 0,
      child: content,
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? UiColors.lavender : null,
        shape: BoxShape.circle,
        border: selected
            ? null
            : Border.all(color: const Color(0xFFD0D0D0), width: 1.5),
      ),
      child: selected
          ? const Icon(UiIcons.check, size: 16, color: UiColors.ink)
          : null,
    );
  }
}
