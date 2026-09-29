import 'package:flutter/painting.dart';

/// Color tokens from PRD-ux-spec.md section 7. Never add a color that is not
/// in that table; derived surfaces the design renders are listed separately.
abstract final class UiColors {
  static const Color bg = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF212121);
  static const Color inkMuted = Color(0xFF6B6B6B);
  static const Color lavender = Color(0xFFCFCAEC);
  static const Color chartreuse = Color(0xFFEAFC5F);
  static const Color chartreuseDeep = Color(0xFFD2E83A);
  static const Color danger = Color(0xFFC62828);
  static const Color warning = Color(0xFFF5C451);
  static const Color glass = Color(0x33FFFFFF);

  /// Soft grey tray used by IconButton/Soft, SaveBar and Toggle in the design.
  static const Color soft = Color(0xFFEDEDED);

  /// Disabled SaveBar greys (design master `SaveBar` Disabled).
  static const Color disabledKnob = Color(0xFFBDBDBD);
  static const Color disabledHandle = Color(0xFFDADADA);

  /// Danger IconButton background: `danger` at 10% alpha.
  static const Color dangerSoft = Color(0x1AC62828);

  /// Translucent tray behind the NavCluster circles.
  static const Color trayFill = Color(0x8CFFFFFF);
  static const Color trayBorder = Color(0xCCFFFFFF);
}
