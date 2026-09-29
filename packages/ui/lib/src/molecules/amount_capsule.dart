import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/joined_shape.dart';
import '../tokens/typography.dart';

/// "$ | value" capsule: a white currency badge on a round lavender lobe, joined
/// by a concave neck to a lavender value lobe that grows with the amount.
///
/// Symbols longer than one character (for example "US$") use a smaller font so
/// they fit the 48 dp badge.
class UiAmountCapsule extends StatelessWidget {
  const UiAmountCapsule({required this.value, this.symbol = r'$', super.key});

  final String value;
  final String symbol;

  static const double _height = 64;
  static const double _lobe = 64;
  static const double _gap = 6;
  static const double _neck = 9;

  static List<JoinedLobe> _lobes(Size size) => [
        const JoinedLobe(x: 0, width: _lobe, radius: _height / 2),
        JoinedLobe(
          x: _lobe + _gap,
          width: size.width - _lobe - _gap,
          radius: _height / 2,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final symbolStyle = UiTypography.custom(symbol.length > 1 ? 14 : 20);
    return Semantics(
      label: '$symbol $value',
      child: ExcludeSemantics(
        child: CustomPaint(
          painter: const JoinedShapePainter(
            lobes: _lobes,
            neck: _neck,
            fill: UiColors.lavender,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _lobe,
                height: _height,
                child: Center(
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
              ),
              const SizedBox(width: _gap),
              Container(
                height: _height,
                constraints: const BoxConstraints(minWidth: 96),
                padding: const EdgeInsets.only(left: 26, right: 30),
                alignment: Alignment.centerLeft,
                child: Text(value, style: UiTypography.display),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
