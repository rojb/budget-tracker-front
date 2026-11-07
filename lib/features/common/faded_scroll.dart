import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Hints that a scrolling list continues below (35, 46, and the tab lists):
/// a [fadeHeight] gradient from transparent to the page background laid over
/// the bottom edge instead of cutting the last row off abruptly.
///
/// It is a plain overlay in a [Stack]: the list is not masked or drawn into an
/// offscreen layer (a `ShaderMask` over a whole list doubled the frame time of
/// 10 and 02), and the overlay ignores pointers, so scrolling, pull to refresh
/// and taps reach the list underneath. The lists end with 32 dp of padding, so
/// their last row at the end of the scroll is clear of the fade.
class FadedScroll extends StatelessWidget {
  const FadedScroll({required this.child, super.key});

  final Widget child;

  /// Height of the fade at the bottom edge.
  static const double fadeHeight = 28;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: fadeHeight,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Same color at both ends so the middle is not grey.
                  colors: [UiColors.bg.withAlpha(0), UiColors.bg],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
