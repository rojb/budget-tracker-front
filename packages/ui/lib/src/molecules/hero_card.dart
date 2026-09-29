import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Photo card of the auth screens (18, 19): a radius-32 image with a dark
/// bottom scrim and a white title and subtitle over it (PRD-ux-spec.md
/// section 7: white text over photos). Without an [image] it falls back to a
/// lavender-to-ink gradient so the package stays free of app imagery.
class UiHeroCard extends StatelessWidget {
  const UiHeroCard({
    required this.title,
    required this.subtitle,
    this.image,
    this.height = 320,
    super.key,
  });

  final String title;
  final String subtitle;
  final ImageProvider? image;
  final double height;

  @override
  Widget build(BuildContext context) {
    final white = UiColors.surface;
    return Semantics(
      container: true,
      label: '$title. $subtitle',
      child: ExcludeSemantics(
        child: Container(
          height: height,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiRadius.photo),
            gradient: image == null
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [UiColors.lavender, UiColors.inkMuted],
                  )
                : null,
            image: image == null
                ? null
                : DecorationImage(image: image!, fit: BoxFit.cover),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.35, 1],
                colors: [
                  UiColors.ink.withAlpha(0),
                  UiColors.ink.withAlpha(214),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: UiTypography.custom(44, weight: 300, color: white),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: UiTypography.custom(16, color: white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
