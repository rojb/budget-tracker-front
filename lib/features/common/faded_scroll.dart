import 'package:flutter/material.dart';

/// Fades the bottom edge of a scrolling list (35, 46): the list is taller than
/// the screen, so a gradient hints that there is more below instead of cutting
/// the last row off abruptly.
class FadedScroll extends StatelessWidget {
  const FadedScroll({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black, Colors.black, Colors.transparent],
        stops: [0, 0.88, 1],
      ).createShader(bounds),
      child: child,
    );
  }
}
