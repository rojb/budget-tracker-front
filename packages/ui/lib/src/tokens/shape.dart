/// Shape and size tokens (PRD-ux-spec.md section 7 "Forma" and the design masters).
abstract final class UiRadius {
  static const double card = 28;
  static const double photo = 32;
  static const double toast = 32;
}

abstract final class UiSizes {
  /// Minimum interactive hit area (dp), WCAG / Material guideline.
  static const double touchTarget = 48;

  static const double iconButton = 52;
  static const double chipHeight = 44;
  static const double chipHeightCompact = 34;
  static const double buttonPrimaryHeight = 56;
  static const double buttonSecondaryHeight = 52;
  static const double toggleHeight = 52;
  static const double textFieldHeight = 60;
  static const double keyHeight = 44;
  static const double avatar = 52;
  static const double saveBarWidth = 340;
  static const double saveBarHeight = 68;
  static const double toastWidth = 350;
  static const double toastHeight = 64;
  static const double fieldRowHeight = 42;
}
