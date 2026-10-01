import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';

/// Progress as the design draws it (PRD-ux-spec.md section 7 "Forma"):
/// chartreuse vertical stripes for the covered part and faint dots for the
/// rest. [value] is clamped to 0..1. Decorative: pair it with a text value.
///
/// Over a photo (05) the covered part is brighter and the dots white: pass
/// [stripeColor] and [dotColor].
class UiStripeBar extends StatelessWidget {
  const UiStripeBar({
    required this.value,
    this.height = 12,
    this.stripeColor = UiColors.chartreuseDeep,
    this.dotColor = const Color(0xFFD9D9D9),
    super.key,
  });

  final double value;
  final double height;
  final Color stripeColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _StripePainter(
            value.clamp(0, 1).toDouble(),
            stripeColor,
            dotColor,
          ),
        ),
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter(this.value, this.stripeColor, this.dotColor);

  final double value;
  final Color stripeColor;
  final Color dotColor;

  static const double _stripe = 2;
  static const double _pitch = 4.5;

  @override
  void paint(Canvas canvas, Size size) {
    final filled = size.width * value;
    final stripe = Paint()..color = stripeColor;
    for (double x = 0; x + _stripe <= filled; x += _pitch) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 0, _stripe, size.height),
          const Radius.circular(1),
        ),
        stripe,
      );
    }
    // Dots on a staggered grid; a fixed seed keeps the texture stable.
    final dot = Paint()..color = dotColor;
    final random = math.Random(7);
    for (double x = filled + 3; x < size.width; x += 3) {
      for (double y = 1.5; y < size.height; y += 3) {
        if (random.nextDouble() < 0.45) {
          canvas.drawCircle(Offset(x, y), 0.8, dot);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_StripePainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.stripeColor != stripeColor ||
      oldDelegate.dotColor != dotColor;
}
