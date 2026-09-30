import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

/// Number between up/down chevrons (hour and minute of 38 Fecha y hora).
class UiStepper extends StatelessWidget {
  const UiStepper({
    required this.value,
    required this.label,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  /// Already formatted ("09").
  final String value;

  /// What the number is, for screen readers ("Hora").
  final String label;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '$label $value',
      child: Container(
        width: 84,
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: UiColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UiHitTarget(
              onTap: onIncrement,
              semanticLabel: 'Subir $label',
              child: const Icon(
                UiIcons.chevronUp,
                size: 18,
                color: UiColors.ink,
              ),
            ),
            ExcludeSemantics(
              child: Text(value, style: UiTypography.custom(26)),
            ),
            UiHitTarget(
              onTap: onDecrement,
              semanticLabel: 'Bajar $label',
              child: const Icon(
                UiIcons.chevronDown,
                size: 18,
                color: UiColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
