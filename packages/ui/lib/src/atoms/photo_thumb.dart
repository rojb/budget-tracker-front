import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Thumbnail of the "Fotos sugeridas" grid of 50 Foto de la meta: a rounded
/// photo; the selected one carries a lavender ring and a check, so selection
/// never depends on colour alone. [UiPhotoThumb.more] is the grey "Más fotos"
/// tile. Tappable with at least 48 dp.
class UiPhotoThumb extends StatelessWidget {
  const UiPhotoThumb({
    required this.image,
    required this.semanticLabel,
    this.selected = false,
    this.onTap,
    super.key,
  }) : label = null,
       icon = null;

  const UiPhotoThumb.more({
    required String this.label,
    this.icon = UiIcons.images,
    this.onTap,
    super.key,
  }) : image = null,
       selected = false,
       semanticLabel = label;

  final ImageProvider? image;
  final String semanticLabel;
  final bool selected;
  final VoidCallback? onTap;
  final String? label;
  final IconData? icon;

  static const double _radius = 20;

  @override
  Widget build(BuildContext context) {
    final Widget body;
    if (image != null) {
      body = Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: Image(
              image: image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const ColoredBox(color: UiColors.soft),
            ),
          ),
          if (selected) ...[
            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_radius),
                  border: Border.all(color: UiColors.lavender, width: 3),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: UiColors.lavender,
                  shape: BoxShape.circle,
                ),
                child: const Icon(UiIcons.check, size: 16, color: UiColors.ink),
              ),
            ),
          ],
        ],
      );
    } else {
      body = DecoratedBox(
        decoration: BoxDecoration(
          color: UiColors.soft,
          borderRadius: BorderRadius.circular(_radius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: UiColors.ink),
            const SizedBox(height: 4),
            Text(
              label!,
              style: UiTypography.custom(14, color: UiColors.inkMuted),
            ),
          ],
        ),
      );
    }
    return Semantics(
      container: true,
      button: onTap != null,
      selected: selected,
      label: semanticLabel,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: UiSizes.touchTarget),
            child: AspectRatio(aspectRatio: 110 / 76, child: body),
          ),
        ),
      ),
    );
  }
}
