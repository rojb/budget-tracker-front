import 'package:flutter/material.dart';

/// Fades the bottom edge of a scrolling list (35, 46): the list is taller than
/// the screen, so a gradient hints that there is more below instead of cutting
/// the last row off abruptly.
class FadedScroll extends StatelessWidget {
  const FadedScroll({required this.child, super.key});

  final Widget child;

  /// Height of the fade at the bottom edge.
  static const double fadeHeight = 28;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      // A fixed-height fade, not a share of the viewport: the lists end with
      // 32 dp of padding, so their last row at the end of the scroll is clear
      // of it on any screen height.
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Colors.black, Colors.black, Colors.transparent],
        stops: [
          0,
          bounds.height > fadeHeight ? 1 - fadeHeight / bounds.height : 0,
          1,
        ],
      ).createShader(bounds),
      child: child,
    );
  }
}
