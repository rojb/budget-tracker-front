import 'package:flutter/widgets.dart';

import '../atoms/stripe_bar.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Goal row of 22 Detalle de sobre (PRD-ux-spec.md section 7 "Forma"): the
/// label ("Objetivo mensual") on the left, its [value] ("$ 180.000 · 100%
/// asignado") on the right and the stripe bar of the progress under them.
///
/// [overspent] draws the full red bar and a red [value], and an optional [note]
/// ("Falta $ 80.000 este mes") sits under the bar, so no state is told by
/// colour alone. Decorative bar: the label and value carry the information.
class UiGoalRow extends StatelessWidget {
  const UiGoalRow({
    required this.label,
    required this.value,
    this.progress = 0,
    this.overspent = false,
    this.note,
    super.key,
  });

  final String label;
  final String value;

  /// 0..1 share of the covered stripes.
  final double progress;
  final bool overspent;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final emphasis = overspent ? UiColors.danger : UiColors.ink;
    return Semantics(
      container: true,
      label: [label, value, ?note].join(', '),
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: UiTypography.custom(18, color: UiColors.inkMuted),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: UiTypography.custom(16, weight: 500, color: emphasis),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (overspent)
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: UiColors.danger,
                  borderRadius: BorderRadius.circular(6),
                ),
              )
            else
              UiStripeBar(value: progress),
            if (note != null) ...[
              const SizedBox(height: 8),
              Text(
                note!,
                style: UiTypography.custom(
                  14,
                  color: overspent ? UiColors.danger : UiColors.inkMuted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
