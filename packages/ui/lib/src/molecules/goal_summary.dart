import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../atoms/stripe_bar.dart';
import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Frosted panel behind the texts of 05 Detalle de meta (PRD-ux-spec.md
/// section 7: over photos, `glass` panels and white text). Over a photo the
/// panel is a blurred dark glass with white content; with [onPhoto] false (the
/// lavender tint) it is a light panel with `ink` content.
class UiGlassPanel extends StatelessWidget {
  const UiGlassPanel({
    required this.child,
    this.onPhoto = true,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final Widget child;
  final bool onPhoto;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiRadius.card),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: padding,
          color: onPhoto
              ? Color.alphaBlend(UiColors.glass, UiColors.ink.withAlpha(110))
              : UiColors.surface.withAlpha(150),
          child: child,
        ),
      ),
    );
  }
}

/// Goal summary of 05: "Objetivo" with the target in `display` Light, "Ya
/// ahorrado" and "Falta" under it, and the stripe bar (chartreuse stripes for
/// what is saved, dots for what is missing). The amounts are written, so the
/// bar is decoration only.
class UiGoalSummary extends StatelessWidget {
  const UiGoalSummary({
    required this.targetLabel,
    required this.savedLabel,
    required this.remainingLabel,
    required this.progress,
    this.onPhoto = true,
    super.key,
  });

  /// Formatted amounts ("$ 600.000").
  final String targetLabel;
  final String savedLabel;
  final String remainingLabel;

  /// 0..1 share of the saved stripes.
  final double progress;
  final bool onPhoto;

  @override
  Widget build(BuildContext context) {
    final text = onPhoto ? UiColors.surface : UiColors.ink;
    final muted = onPhoto ? UiColors.surface.withAlpha(210) : UiColors.inkMuted;
    Widget column(String label, String value, CrossAxisAlignment align) =>
        Column(
          crossAxisAlignment: align,
          children: [
            Text(label, style: UiTypography.custom(15, color: muted)),
            const SizedBox(height: 2),
            Text(
              value,
              style: UiTypography.custom(30, weight: 300, color: text),
            ),
          ],
        );
    return Semantics(
      container: true,
      label:
          'Objetivo $targetLabel, ya ahorrado $savedLabel, falta $remainingLabel',
      child: ExcludeSemantics(
        child: UiGlassPanel(
          onPhoto: onPhoto,
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Objetivo', style: UiTypography.custom(16, color: muted)),
              const SizedBox(height: 2),
              Text(
                targetLabel,
                style: UiTypography.custom(40, weight: 300, color: text),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: column(
                      'Ya ahorrado',
                      savedLabel,
                      CrossAxisAlignment.end,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: column(
                      'Falta',
                      remainingLabel,
                      CrossAxisAlignment.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              UiStripeBar(
                value: progress,
                height: 58,
                stripeColor: onPhoto
                    ? UiColors.chartreuse
                    : UiColors.chartreuseDeep,
                dotColor: onPhoto
                    ? UiColors.surface.withAlpha(190)
                    : const Color(0xFFBDBDBD),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
