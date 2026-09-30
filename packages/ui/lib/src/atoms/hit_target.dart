import 'package:flutter/widgets.dart';

import '../tokens/shape.dart';

/// Internal helper: wraps a smaller visual in a tappable area of at least
/// 48 x 48 dp (touch-target rule) and adds button semantics.
class UiHitTarget extends StatelessWidget {
  const UiHitTarget({
    required this.child,
    required this.onTap,
    this.semanticLabel,
    this.selected,
    this.minWidth = UiSizes.touchTarget,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool? selected;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    // container: each tappable is its own node, so neighbouring controls do
    // not merge into one button for screen readers.
    return Semantics(
      container: true,
      button: true,
      enabled: onTap != null,
      selected: selected,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            minHeight: UiSizes.touchTarget,
          ),
          child: Center(widthFactor: 1, heightFactor: 1, child: child),
        ),
      ),
    );
  }
}
