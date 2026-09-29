import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

enum UiKeyVariant { number, operator, del }

/// Calculator keypad key: Number (surface), Operator (lavender), Del (backspace icon).
class UiKey extends StatelessWidget {
  const UiKey({
    required this.onPressed,
    this.label,
    this.variant = UiKeyVariant.number,
    this.width = 100,
    super.key,
  }) : assert(
         variant == UiKeyVariant.del || label != null,
         'Number and Operator keys need a label',
       );

  final String? label;
  final UiKeyVariant variant;
  final VoidCallback? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDel = variant == UiKeyVariant.del;
    return UiHitTarget(
      onTap: onPressed,
      semanticLabel: isDel ? 'Borrar' : label,
      minWidth: 0,
      child: Container(
        width: width,
        height: UiSizes.keyHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: variant == UiKeyVariant.operator
              ? UiColors.lavender
              : UiColors.surface,
          borderRadius: BorderRadius.circular(UiSizes.keyHeight / 2),
        ),
        child: isDel
            ? const Icon(UiIcons.delete, size: 18, color: UiColors.ink)
            : ExcludeSemantics(
                child: Text(label!, style: UiTypography.custom(18)),
              ),
      ),
    );
  }
}
