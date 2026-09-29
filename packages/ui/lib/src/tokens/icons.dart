import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Named aliases over the Lucide icon set, stroke weight 300 (= 1.5 stroke,
/// PRD-ux-spec.md section 7). Components import only this class, so swapping
/// the icon source is a one-file change.
abstract final class UiIcons {
  static const IconData house = LucideIcons.house300;
  static const IconData wallet = LucideIcons.wallet300;
  static const IconData arrowLeftRight = LucideIcons.arrowLeftRight300;
  static const IconData creditCard = LucideIcons.creditCard300;
  static const IconData plus = LucideIcons.plus300;
  static const IconData star = LucideIcons.star300;
  static const IconData sparkles = LucideIcons.sparkles300;
  static const IconData check = LucideIcons.check300;
  static const IconData calculator = LucideIcons.calculator300;
  static const IconData lock = LucideIcons.lock300;
  static const IconData mail = LucideIcons.mail300;
  static const IconData eye = LucideIcons.eye300;
  static const IconData chevronRight = LucideIcons.chevronRight300;
  static const IconData delete = LucideIcons.delete300;
  static const IconData undo = LucideIcons.rotateCcw300;
  static const IconData info = LucideIcons.info300;
  static const IconData warning = LucideIcons.triangleAlert300;
  static const IconData error = LucideIcons.circleX300;
}
