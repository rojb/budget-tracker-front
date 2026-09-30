import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

enum UiSplitRowVariant {
  /// A portion already given an envelope: lavender amount pill.
  part,

  /// The last row "Elegí un sobre": it adds a portion with what is left.
  pending,
}

/// Portion card of 08 Dividir pago: icon circle, name, "$ 24.000 disponible"
/// and the amount as a pill. A [part] shows a lavender pill that edits the
/// amount; the [pending] row shows a plus icon, "Elegí un sobre" and a pill
/// with the amount still to distribute, tinted red while something is left
/// ([attention]) and muted when nothing is.
class UiSplitRow extends StatelessWidget {
  const UiSplitRow({
    required this.name,
    required this.amount,
    this.variant = UiSplitRowVariant.part,
    this.icon,
    this.subtitle,
    this.attention = false,
    this.onTap,
    this.onAmountTap,
    this.onLongPress,
    this.longPressLabel,
    super.key,
  });

  final String name;

  /// Formatted amount of the pill ("$ 15.800").
  final String amount;
  final UiSplitRowVariant variant;

  /// Envelope icon of a part; the pending row always shows a plus.
  final IconData? icon;

  /// Line under the name, e.g. "$ 24.000 disponible".
  final String? subtitle;

  /// Pending row only: red pill (an amount is still left to distribute).
  final bool attention;

  /// Opens the envelope picker.
  final VoidCallback? onTap;

  /// Opens the amount editor (the pill of a part).
  final VoidCallback? onAmountTap;

  /// Removes the part; also exposed to screen readers as a custom action.
  final VoidCallback? onLongPress;
  final String? longPressLabel;

  @override
  Widget build(BuildContext context) {
    final pending = variant == UiSplitRowVariant.pending;
    final Color pillColor;
    final Color pillInk;
    if (!pending) {
      pillColor = UiColors.lavender;
      pillInk = UiColors.ink;
    } else if (attention) {
      pillColor = UiColors.dangerSoft;
      pillInk = UiColors.danger;
    } else {
      pillColor = UiColors.soft;
      pillInk = UiColors.inkMuted;
    }
    final pill = Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: pillColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(amount, style: UiTypography.custom(17, color: pillInk)),
    );
    final pillTarget = onAmountTap == null
        ? pill
        : Semantics(
            button: true,
            label: 'Monto de $name, $amount, editar',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onAmountTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: UiSizes.touchTarget,
                  minHeight: UiSizes.touchTarget,
                ),
                child: Center(
                  widthFactor: 1,
                  child: ExcludeSemantics(child: pill),
                ),
              ),
            ),
          );
    final content = Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 68),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: UiColors.surface,
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: UiColors.bg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              pending ? UiIcons.plus : (icon ?? UiIcons.tag),
              size: 21,
              color: UiColors.ink,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: UiTypography.custom(
                      18,
                      color: pending ? UiColors.inkMuted : UiColors.ink,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(14, color: UiColors.inkMuted),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          pillTarget,
        ],
      ),
    );
    final label = [name, ?subtitle, amount].join(', ');
    return Semantics(
      container: true,
      button: onTap != null,
      label: label,
      customSemanticsActions: {
        CustomSemanticsAction(label: longPressLabel ?? 'Quitar parte'):
            ?onLongPress,
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        onLongPress: onLongPress,
        child: content,
      ),
    );
  }
}
