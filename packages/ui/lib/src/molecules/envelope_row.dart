import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import '../atoms/stripe_bar.dart';
import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// The four EnvelopeRow variants of PRD-ux-spec.md section 8.
enum UiEnvelopeRowVariant {
  /// Money available: "Disponible" (or "Cubierto") under the amount.
  funded,

  /// Not yet covered: "Falta $ X" under the amount, partial stripes.
  underfunded,

  /// Spent more than it had: red icon, red amount and caption, full red bar.
  overspent,

  /// Nothing assigned: muted amount and no bar.
  empty,
}

/// Envelope row of the plan (02, 04, 33): icon circle, name, subtitle
/// ("$ 51.200 de $ 45.000"), amount with its state caption on the right and a
/// bar of the spending under them. It has no chevron (section 8, "Chevrons en
/// filas"): the right column is a tight two-line stack, and the whole row is
/// still tappable.
class UiEnvelopeRow extends StatelessWidget {
  const UiEnvelopeRow({
    required this.icon,
    required this.name,
    this.variant = UiEnvelopeRowVariant.funded,
    this.subtitle,
    this.subtitleMaxLines = 1,
    this.amount,
    this.caption,
    this.progress = 0,
    this.card = true,
    this.onTap,
    this.onLongPress,
    this.longPressLabel,
    super.key,
  });

  final IconData icon;
  final String name;
  final UiEnvelopeRowVariant variant;

  /// Line under the name, e.g. "$ 132.450 de $ 180.000".
  final String? subtitle;

  /// Lines the subtitle may take; 2 for the compact card of 53, whose
  /// subtitle carries the resulting amount and must not be cut.
  final int subtitleMaxLines;

  /// Formatted available amount; the right column is left out when null (the
  /// summary of 43 Eliminar sobre).
  final String? amount;

  /// Word under the amount; defaults to the variant's ("Disponible",
  /// "Sobregirado", "Sin asignar").
  final String? caption;

  /// 0..1 share of the stripe bar (spending over assignment). Overspent draws
  /// a full red bar and Empty none, whatever the value.
  final double progress;

  /// Wraps the row in its own white card, as 02 draws it.
  final bool card;
  final VoidCallback? onTap;

  /// Secondary action, also exposed to screen readers as a custom action.
  final VoidCallback? onLongPress;
  final String? longPressLabel;

  String get _caption =>
      caption ??
      switch (variant) {
        UiEnvelopeRowVariant.funded => 'Disponible',
        UiEnvelopeRowVariant.underfunded => 'Falta',
        UiEnvelopeRowVariant.overspent => 'Sobregirado',
        UiEnvelopeRowVariant.empty => 'Sin asignar',
      };

  @override
  Widget build(BuildContext context) {
    final overspent = variant == UiEnvelopeRowVariant.overspent;
    final empty = variant == UiEnvelopeRowVariant.empty;
    final ink = empty ? UiColors.inkMuted : UiColors.ink;
    final emphasis = overspent ? UiColors.danger : ink;
    final top = Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: overspent ? UiColors.dangerSoft : UiColors.bg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 21,
            color: overspent ? UiColors.danger : UiColors.ink,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UiTypography.custom(18),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  maxLines: subtitleMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(14, color: UiColors.inkMuted),
                ),
              ],
            ],
          ),
        ),
        if (amount != null) ...[
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount!,
                style: UiTypography.custom(
                  20,
                  weight: empty ? 400 : 500,
                  color: emphasis,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _caption,
                style: UiTypography.custom(
                  14,
                  color: overspent ? UiColors.danger : UiColors.inkMuted,
                ),
              ),
            ],
          ),
        ],
      ],
    );
    final bar = switch (variant) {
      UiEnvelopeRowVariant.overspent => Container(
        height: 12,
        decoration: BoxDecoration(
          color: UiColors.danger,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      UiEnvelopeRowVariant.empty => null,
      _ => UiStripeBar(value: progress),
    };
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        top,
        if (bar != null && amount != null) ...[
          const SizedBox(height: 14),
          ExcludeSemantics(child: bar),
        ],
      ],
    );
    final framed = card
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            decoration: BoxDecoration(
              color: UiColors.surface,
              borderRadius: BorderRadius.circular(UiRadius.card),
            ),
            child: content,
          )
        : content;
    final label = [name, ?subtitle, ?amount, if (amount != null) _caption].join(', ');
    final body = ExcludeSemantics(child: framed);
    if (onTap == null && onLongPress == null) {
      return Semantics(container: true, label: label, child: body);
    }
    return Semantics(
      container: true,
      button: onTap != null,
      label: label,
      customSemanticsActions: {
        CustomSemanticsAction(label: longPressLabel ?? 'Más acciones'):
            ?onLongPress,
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        onLongPress: onLongPress,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: UiSizes.touchTarget),
          child: body,
        ),
      ),
    );
  }
}
