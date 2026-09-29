import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'typography.dart';

/// Tokens that Material has no slot for, exposed through `Theme.of(context)`.
@immutable
class UiTheme extends ThemeExtension<UiTheme> {
  const UiTheme({
    this.lavender = UiColors.lavender,
    this.chartreuse = UiColors.chartreuse,
    this.chartreuseDeep = UiColors.chartreuseDeep,
    this.warning = UiColors.warning,
    this.glass = UiColors.glass,
    this.inkMuted = UiColors.inkMuted,
  });

  final Color lavender;
  final Color chartreuse;
  final Color chartreuseDeep;
  final Color warning;
  final Color glass;
  final Color inkMuted;

  @override
  UiTheme copyWith({
    Color? lavender,
    Color? chartreuse,
    Color? chartreuseDeep,
    Color? warning,
    Color? glass,
    Color? inkMuted,
  }) {
    return UiTheme(
      lavender: lavender ?? this.lavender,
      chartreuse: chartreuse ?? this.chartreuse,
      chartreuseDeep: chartreuseDeep ?? this.chartreuseDeep,
      warning: warning ?? this.warning,
      glass: glass ?? this.glass,
      inkMuted: inkMuted ?? this.inkMuted,
    );
  }

  @override
  UiTheme lerp(ThemeExtension<UiTheme>? other, double t) {
    if (other is! UiTheme) return this;
    return UiTheme(
      lavender: Color.lerp(lavender, other.lavender, t)!,
      chartreuse: Color.lerp(chartreuse, other.chartreuse, t)!,
      chartreuseDeep: Color.lerp(chartreuseDeep, other.chartreuseDeep, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
    );
  }
}

extension UiThemeContext on BuildContext {
  UiTheme get ui => Theme.of(this).extension<UiTheme>() ?? const UiTheme();
}

/// Status bar icon brightness (PRD-ux-spec.md 6.1 rule 8). The status bar
/// itself is drawn by the OS, not by a widget.
abstract final class UiOverlay {
  /// Dark icons over light backgrounds.
  static const SystemUiOverlayStyle onLight = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  /// White icons over photos.
  static const SystemUiOverlayStyle onPhoto = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );
}

/// Builds the app theme from the design tokens.
ThemeData buildUiTheme() {
  const scheme = ColorScheme.light(
    primary: UiColors.ink,
    onPrimary: UiColors.surface,
    secondary: UiColors.lavender,
    onSecondary: UiColors.ink,
    tertiary: UiColors.chartreuse,
    onTertiary: UiColors.ink,
    error: UiColors.danger,
    onError: UiColors.surface,
    surface: UiColors.surface,
    onSurface: UiColors.ink,
    onSurfaceVariant: UiColors.inkMuted,
  );

  final textTheme = TextTheme(
    displayLarge: UiTypography.display,
    headlineLarge: UiTypography.headline,
    titleLarge: UiTypography.title,
    bodyLarge: UiTypography.body,
    bodyMedium: UiTypography.body,
    titleMedium: UiTypography.bodyStrong,
    bodySmall: UiTypography.caption,
    labelSmall: UiTypography.caption,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: UiColors.bg,
    canvasColor: UiColors.bg,
    fontFamily: UiTypography.family,
    package: UiTypography.package,
    textTheme: textTheme,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: UiColors.bg,
      elevation: 0,
      systemOverlayStyle: UiOverlay.onLight,
    ),
    extensions: const [UiTheme()],
  );
}
