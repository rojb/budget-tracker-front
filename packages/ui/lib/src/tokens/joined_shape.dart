import 'package:flutter/widgets.dart';

/// One rounded block of a joined shape: starts at [x], is [width] wide and
/// fills the shape height; [radius] is its corner radius.
class JoinedLobe {
  const JoinedLobe({
    required this.x,
    required this.width,
    required this.radius,
  });

  final double x;
  final double width;
  final double radius;
}

/// Computes the lobes of a joined shape for a given paint [Size].
typedef JoinedLobesBuilder = List<JoinedLobe> Function(Size size);

/// Builds one closed outline made of rounded [lobes] fused by concave "necks".
///
/// Port of `design/shapes.js#blobPath` (PRD-ux-spec.md section 7 "Forma"): the
/// top and bottom edges leave each lobe, dip inward by [neck] at the midpoint
/// between two lobes and rise onto the next one. Consecutive lobes may overlap
/// or leave a small gap. All lobes share the same [height].
Path joinedShapePath({
  required List<JoinedLobe> lobes,
  required double height,
  required double neck,
}) {
  const k = 0.5523; // cubic approximation of a quarter circle
  final h = height;
  final path = Path();

  // Top edge, left to right.
  for (var i = 0; i < lobes.length; i++) {
    final lobe = lobes[i];
    final x = lobe.x;
    final w = lobe.width;
    final r = lobe.radius;
    if (i == 0) {
      path
        ..moveTo(x, r)
        ..cubicTo(x, r - r * k, x + r - r * k, 0, x + r, 0);
    }
    if (i + 1 < lobes.length) {
      final next = lobes[i + 1];
      final a = x + w - r;
      final b = next.x + next.radius;
      final mid = (x + w + next.x) / 2;
      path
        ..lineTo(a, 0)
        ..cubicTo(a + r * 0.75, 0, mid - r * 0.35, neck, mid, neck)
        ..cubicTo(mid + next.radius * 0.35, neck, b - next.radius * 0.75, 0, b, 0);
    } else {
      path
        ..lineTo(x + w - r, 0)
        ..cubicTo(x + w - r + r * k, 0, x + w, r - r * k, x + w, r)
        ..lineTo(x + w, h - r)
        ..cubicTo(x + w, h - r + r * k, x + w - r + r * k, h, x + w - r, h);
    }
  }

  // Bottom edge, right to left (mirror of the top).
  for (var i = lobes.length - 1; i >= 0; i--) {
    final lobe = lobes[i];
    final x = lobe.x;
    final r = lobe.radius;
    if (i > 0) {
      final prev = lobes[i - 1];
      final a = x + r;
      final b = prev.x + prev.width - prev.radius;
      final mid = (prev.x + prev.width + x) / 2;
      path
        ..lineTo(a, h)
        ..cubicTo(a - r * 0.75, h, mid + r * 0.35, h - neck, mid, h - neck)
        ..cubicTo(
          mid - prev.radius * 0.35,
          h - neck,
          b + prev.radius * 0.75,
          h,
          b,
          h,
        );
    } else {
      path
        ..lineTo(x + r, h)
        ..cubicTo(x + r - r * k, h, x, h - r + r * k, x, h - r)
        ..close();
    }
  }
  return path;
}

/// Clips a child to a joined shape (for example to blur a backdrop inside it).
class JoinedShapeClipper extends CustomClipper<Path> {
  const JoinedShapeClipper({required this.lobes, required this.neck});

  final JoinedLobesBuilder lobes;
  final double neck;

  @override
  Path getClip(Size size) =>
      joinedShapePath(lobes: lobes(size), height: size.height, neck: neck);

  @override
  bool shouldReclip(covariant JoinedShapeClipper oldClipper) =>
      oldClipper.neck != neck;
}

/// Paints a joined shape: optional [shadow] (drawn outside the shape only),
/// then optional [fill] and [stroke].
class JoinedShapePainter extends CustomPainter {
  const JoinedShapePainter({
    required this.lobes,
    required this.neck,
    this.fill,
    this.stroke,
    this.strokeWidth = 1,
    this.shadow,
  });

  final JoinedLobesBuilder lobes;
  final double neck;
  final Color? fill;
  final Color? stroke;
  final double strokeWidth;
  final BoxShadow? shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final path =
        joinedShapePath(lobes: lobes(size), height: size.height, neck: neck);

    final shadow = this.shadow;
    if (shadow != null) {
      canvas
        ..save()
        ..clipPath(
          Path.combine(
            PathOperation.difference,
            Path()
              ..addRect(
                Rect.fromLTWH(
                  -size.width,
                  -size.height,
                  size.width * 3,
                  size.height * 3,
                ),
              ),
            path,
          ),
        )
        ..drawPath(
          path.shift(shadow.offset),
          shadow.toPaint(),
        )
        ..restore();
    }
    if (fill != null) {
      canvas.drawPath(path, Paint()..color = fill!);
    }
    if (stroke != null) {
      canvas.drawPath(
        path,
        Paint()
          ..color = stroke!
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(covariant JoinedShapePainter old) =>
      old.neck != neck ||
      old.fill != fill ||
      old.stroke != stroke ||
      old.strokeWidth != strokeWidth ||
      old.shadow != shadow;
}
