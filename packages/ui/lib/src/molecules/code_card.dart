import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../atoms/icon_button.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Invitation code card of 21: the code in large type with a copy button, an
/// optional [qr] slot (the app passes the QR widget, so this package needs no
/// QR dependency) and a caption. While [copied] is true a "Copiado" label
/// floats over the code (PRD-ux-spec.md §5, ~1.5 s, the parent times it).
class UiCodeCard extends StatelessWidget {
  const UiCodeCard({
    required this.code,
    required this.onCopy,
    this.qr,
    this.caption,
    this.copied = false,
    super.key,
  });

  final String code;
  final VoidCallback onCopy;
  final Widget? qr;
  final String? caption;
  final bool copied;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 20, 20),
      decoration: BoxDecoration(
        color: UiColors.surface,
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Expanded(
                    child: UiHitTarget(
                      onTap: onCopy,
                      semanticLabel: 'Código $code, copiar',
                      minWidth: 0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ExcludeSemantics(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              code,
                              style: UiTypography.custom(38, weight: 500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  UiIconButton(
                    icon: UiIcons.copy,
                    variant: UiIconButtonVariant.soft,
                    semanticLabel: 'Copiar código',
                    onPressed: onCopy,
                  ),
                ],
              ),
              if (copied)
                Positioned(
                  left: 0,
                  top: -26,
                  child: Semantics(
                    liveRegion: true,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: UiColors.lavender,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text('Copiado', style: UiTypography.custom(13)),
                    ),
                  ),
                ),
            ],
          ),
          if (qr != null) ...[const SizedBox(height: 16), qr!],
          if (caption != null) ...[
            const SizedBox(height: 14),
            Text(
              caption!,
              style: UiTypography.custom(14, color: UiColors.inkMuted),
            ),
          ],
        ],
      ),
    );
  }
}
