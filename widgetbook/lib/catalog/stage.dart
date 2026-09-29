import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Wraps a use case on the screen background so stories match the design renders.
Widget stage(Widget child, {Alignment alignment = Alignment.topLeft}) {
  return Container(
    color: UiColors.bg,
    alignment: alignment,
    padding: const EdgeInsets.all(24),
    child: child,
  );
}

/// Labelled row used by stories that show several variants together.
Widget labelled(String label, Widget child) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(label, style: UiTypography.caption),
        ),
        child,
      ],
    ),
  );
}
