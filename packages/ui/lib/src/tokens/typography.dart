import 'package:flutter/painting.dart';

import 'colors.dart';

/// Urbanist type scale from PRD-ux-spec.md section 7.
///
/// Urbanist ships as one variable font, so each style sets the `wght` axis
/// explicitly besides `fontWeight`.
abstract final class UiTypography {
  static const String family = 'Urbanist';
  static const String package = 'ui';

  static TextStyle _style(double size, int weight, {Color color = UiColors.ink}) {
    return TextStyle(
      fontFamily: family,
      package: package,
      fontSize: size,
      fontWeight: FontWeight.values[(weight ~/ 100) - 1],
      fontVariations: [FontVariation('wght', weight.toDouble())],
      color: color,
      height: 1.2,
    );
  }

  /// Build any Urbanist style outside the fixed scale (component-specific
  /// sizes from the design masters, e.g. 15/500 for toast titles).
  static TextStyle custom(double size, {int weight = 400, Color color = UiColors.ink}) =>
      _style(size, weight, color: color);

  static final TextStyle display = _style(40, 300);
  static final TextStyle headline = _style(34, 400);
  static final TextStyle title = _style(22, 400);
  static final TextStyle body = _style(16, 400);
  static final TextStyle bodyStrong = _style(16, 500);
  static final TextStyle caption = _style(13, 400, color: UiColors.inkMuted);
}
