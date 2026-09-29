import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// "$ | value" capsule: a white currency badge in a round lavender lobe, joined
/// by a short neck to a lavender value lobe that grows with the amount.
///
/// Symbols longer than one character (for example "US$") use a smaller font so
/// they fit the 48 dp badge.
class UiAmountCapsule extends StatelessWidget {
  const UiAmountCapsule({
    required this.value,
    this.symbol = r'$',
    super.key,
  });

  final String value;
  final String symbol;

  static const double _height = 64;
  static const double _lobe = 64;
  static const double _gap = 6;
  static const double _neck = 9;

  @override
  Widget build(BuildContext context) {
    final symbolStyle = UiTypography.custom(symbol.length > 1 ? 14 : 20);
    return Semantics(
      label: '$symbol $value',
      child: ExcludeSemantics(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: _lobe,
                  height: _height,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: UiColors.lavender,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: UiColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Text(symbol, style: symbolStyle),
                  ),
                ),
                const SizedBox(width: _gap),
                Container(
                  height: _height,
                  constraints: const BoxConstraints(minWidth: 96),
                  padding: const EdgeInsets.only(left: 26, right: 30),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: UiColors.lavender,
                    borderRadius: BorderRadius.circular(_height / 2),
                  ),
                  child: Text(value, style: UiTypography.display),
                ),
              ],
            ),
            // Neck joining the two lobes.
            const Positioned(
              left: _lobe - 12,
              top: _neck,
              bottom: _neck,
              width: _gap + 24,
              child: ColoredBox(color: UiColors.lavender),
            ),
          ],
        ),
      ),
    );
  }
}
