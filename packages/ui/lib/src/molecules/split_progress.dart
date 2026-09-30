import 'package:flutter/widgets.dart';

import '../atoms/stripe_bar.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Progress of a split payment (08): the stripe bar with the share already
/// distributed, "Repartido $ X" on the left and "Restan $ Y" on the right.
/// The right label changes text ("Sobran") when the parts exceed the total,
/// so the state is never told by color alone.
class UiSplitProgress extends StatelessWidget {
  const UiSplitProgress({
    required this.value,
    required this.distributed,
    required this.remaining,
    super.key,
  });

  /// 0..1 share of the total already distributed.
  final double value;

  /// Formatted distributed amount, e.g. "Repartido $ 21.800".
  final String distributed;

  /// Formatted remainder, e.g. "Restan $ 2.500".
  final String remaining;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '$distributed, $remaining',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UiStripeBar(value: value, height: 50),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(distributed, style: UiTypography.custom(17)),
                ),
                Text(
                  remaining,
                  style: UiTypography.custom(17, color: UiColors.ink),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
