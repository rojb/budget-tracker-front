import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// `GoalCard` of PRD-ux-spec.md section 8 (carousel of 01 Inicio): the goal's
/// photo with radius 32 and a scrim, or, without one, a lavender tint with the
/// goal's [icon]. Both show the saved amount and the percent over a progress
/// line, and a `glass` panel with the name, a subtitle and an arrow.
///
/// Text over a photo is white with a soft shadow; over the tint it is `ink`,
/// so no forbidden contrast pair is drawn (section 7). The package knows no
/// API: the photo arrives as an [ImageProvider].
class UiGoalCard extends StatelessWidget {
  const UiGoalCard({
    required this.name,
    required this.subtitle,
    required this.savedLabel,
    required this.percent,
    required this.icon,
    this.image,
    this.height = 300,
    this.onTap,
    super.key,
  });

  final String name;

  /// "$ 600.000 · diciembre".
  final String subtitle;

  /// Formatted saved amount ("$ 360.000").
  final String savedLabel;

  /// 0..100.
  final int percent;

  /// Glyph shown on the tint and in the panel.
  final IconData icon;

  /// The goal's photo; the lavender tint is drawn when null.
  final ImageProvider? image;
  final double height;
  final VoidCallback? onTap;

  bool get _hasPhoto => image != null;

  @override
  Widget build(BuildContext context) {
    final onPhoto = _hasPhoto;
    final text = onPhoto ? UiColors.surface : UiColors.ink;
    final shadow = onPhoto
        ? const [
            Shadow(
              color: Color(0x66000000),
              blurRadius: 6,
              offset: Offset(0, 1),
            ),
          ]
        : const <Shadow>[];
    final value = (percent.clamp(0, 100)) / 100;
    final card = Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: UiColors.lavender,
        borderRadius: BorderRadius.circular(UiRadius.photo),
        image: onPhoto
            ? DecorationImage(image: image!, fit: BoxFit.cover)
            : null,
      ),
      child: Stack(
        children: [
          if (onPhoto)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.4, 1],
                    colors: [
                      UiColors.ink.withAlpha(0),
                      UiColors.ink.withAlpha(185),
                    ],
                  ),
                ),
              ),
            )
          else
            Positioned(
              top: 28,
              left: 0,
              right: 0,
              child: Icon(icon, size: 96, color: UiColors.ink.withAlpha(60)),
            ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 14,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      savedLabel,
                      style: UiTypography.custom(
                        20,
                        weight: 300,
                        color: text,
                      ).copyWith(shadows: shadow),
                    ),
                    Text(
                      '$percent%',
                      style: UiTypography.custom(
                        18,
                        weight: 300,
                        color: text,
                      ).copyWith(shadows: shadow),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _ProgressLine(value: value, color: text),
                const SizedBox(height: 12),
                _GlassPanel(
                  icon: icon,
                  name: name,
                  subtitle: subtitle,
                  onPhoto: onPhoto,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    final label = [name, subtitle, savedLabel, '$percent%'].join(', ');
    return Semantics(
      container: true,
      button: onTap != null,
      label: label,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: UiSizes.touchTarget),
            child: card,
          ),
        ),
      ),
    );
  }
}

/// The thin line of the card: the covered share solid, the rest faint.
class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.withAlpha(70),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: value,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
              child: const SizedBox(height: 3),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.onPhoto,
  });

  final IconData icon;
  final String name;
  final String subtitle;
  final bool onPhoto;

  @override
  Widget build(BuildContext context) {
    final text = onPhoto ? UiColors.surface : UiColors.ink;
    final circle = onPhoto ? UiColors.glass : UiColors.surface.withAlpha(150);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: onPhoto
            ? UiColors.ink.withAlpha(90)
            : UiColors.surface.withAlpha(140),
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: circle, shape: BoxShape.circle),
            child: Icon(icon, size: 21, color: text),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(22, color: text),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(14, color: text),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: circle, shape: BoxShape.circle),
            child: Icon(UiIcons.arrowUpRight, size: 20, color: text),
          ),
        ],
      ),
    );
  }
}
