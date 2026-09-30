import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../atoms/stripe_bar.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

enum UiAccountRowVariant {
  /// 13 Cuentas: share caption and a stripe bar of the share under the row.
  standard,

  /// 37 Elegir cuenta: radio (or lavender check when [UiAccountRow.selected])
  /// instead of the bar.
  selectable,

  /// 51 Cuentas archivadas: muted icon and name, [UiAccountRow.trailing] slot
  /// (the "Restaurar" chip) under the amount.
  archived,
}

/// Account row content: icon circle, name and subtitle, amount and caption.
/// It has no background, so the screen decides whether it sits in its own
/// card (13, 51) or in a shared list card (37). No chevron: the right column
/// is a two-line amount stack (PRD-ux-spec.md section 8, "Chevrons en filas").
class UiAccountRow extends StatelessWidget {
  const UiAccountRow({
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.amount,
    this.caption,
    this.share,
    this.variant = UiAccountRowVariant.standard,
    this.selected = false,
    this.trailing,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String name;
  final String subtitle;

  /// Formatted balance, e.g. "$ 842.300".
  final String amount;

  /// Line under the amount, e.g. "84% del total".
  final String? caption;

  /// 0..1 share of the total, drawn as the stripe bar (standard variant).
  final double? share;
  final UiAccountRowVariant variant;
  final bool selected;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final archived = variant == UiAccountRowVariant.archived;
    final ink = archived ? UiColors.inkMuted : UiColors.ink;
    final row = Row(
      crossAxisAlignment: archived
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: UiColors.bg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: ink),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ExcludeSemantics(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(18, color: ink),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: archived ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(14, color: UiColors.inkMuted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Texts are already in the row's label; only [trailing] (a chip
            // with its own action) stays in the semantics tree.
            ExcludeSemantics(
              child: Text(
                amount,
                style: UiTypography.custom(17, weight: 500, color: ink),
              ),
            ),
            if (caption != null) ...[
              const SizedBox(height: 2),
              ExcludeSemantics(
                child: Text(
                  caption!,
                  style: UiTypography.custom(13, color: UiColors.inkMuted),
                ),
              ),
            ],
            if (trailing != null) ...[const SizedBox(height: 6), trailing!],
          ],
        ),
        if (variant == UiAccountRowVariant.selectable) ...[
          const SizedBox(width: 14),
          _Radio(selected: selected),
        ],
      ],
    );

    final content = variant == UiAccountRowVariant.standard && share != null
        ? Column(
            children: [
              row,
              const SizedBox(height: 14),
              UiStripeBar(value: share!),
            ],
          )
        : row;

    final label = [name, subtitle, amount, ?caption].join(', ');
    if (onTap == null) {
      // Not tappable (48, 51): a plain labelled group, not a disabled button,
      // so a trailing action inside it stays enabled for screen readers.
      return Semantics(container: true, label: label, child: content);
    }
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      selected: variant == UiAccountRowVariant.selectable ? selected : null,
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

/// White rounded card that hosts rows on the list screens (13, 16, 37, 51).
class UiCard extends StatelessWidget {
  const UiCard({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.color = UiColors.surface,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: child,
    );
  }
}
