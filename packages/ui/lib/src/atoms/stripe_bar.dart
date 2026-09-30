import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';

/// Progress as the design draws it (PRD-ux-spec.md section 7 "Forma"):
/// chartreuse vertical stripes for the covered part and faint dots for the
/// rest. [value] is clamped to 0..1. Decorative: pair it with a text value.
class UiStripeBar extends StatelessWidget {
  const UiStripeBar({required this.value, this.height = 12, super.key});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _StripePainter(value.clamp(0, 1).toDouble()),
        ),
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter(this.value);

  final double value;

  static const double _stripe = 2;
  static const double _pitch = 4.5;
  static const Color _dot = Color(0xFFD9D9D9);

  @override
  void paint(Canvas canvas, Size size) {
    final filled = size.width * value;
    final stripe = Paint()..color = UiColors.chartreuseDeep;
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
    final dot = Paint()..color = _dot;
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
  bool shouldRepaint(_StripePainter oldDelegate) => oldDelegate.value != value;
}
