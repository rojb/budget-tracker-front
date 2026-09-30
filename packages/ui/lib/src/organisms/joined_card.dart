import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/joined_shape.dart';
import '../tokens/typography.dart';

/// The joined card of 01/02/04/06/13/33 ("Listo para asignar" + "Sobres
/// activos", "Saldo total" + "Cuentas") and 14 ("Entró" + "Salió"): two white
/// blocks fused by a curved pinch, a figure with its label in each, and an
/// optional 52 dp "+" in the top-right corner (lavender, or muted while the
/// action is not available yet, e.g. 06 with 0 envelopes).
class UiJoinedCard extends StatelessWidget {
  const UiJoinedCard({
    required this.primaryValue,
    required this.primaryLabel,
    required this.secondaryValue,
    required this.secondaryLabel,
    this.onAdd,
    this.addEnabled = true,
    this.addLabel = 'Agregar',
    this.secondaryIsAmount = false,
    super.key,
  });

  final String primaryValue;
  final String primaryLabel;
  final String secondaryValue;
  final String secondaryLabel;

  /// Shows the "+" when set.
  final VoidCallback? onAdd;

  /// False draws the "+" muted (soft grey) and ignores taps.
  final bool addEnabled;
  final String addLabel;

  /// True when the right figure is an amount (14) instead of a count, which
  /// uses a smaller size so both amounts fit.
  final bool secondaryIsAmount;

  static const double _height = 128;
  static const double _split = 0.62;
  static const double _neck = 14;

  static List<JoinedLobe> _lobes(Size size) {
    final left = size.width * _split;
    return [
      JoinedLobe(x: 0, width: left - 10, radius: 34),
      JoinedLobe(x: left + 10, width: size.width - left - 10, radius: 34),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = UiTypography.display;
    final secondaryStyle = secondaryIsAmount
        ? UiTypography.custom(34, weight: 300)
        : UiTypography.display;
    final labelStyle = UiTypography.custom(15, color: UiColors.inkMuted);
    return SizedBox(
      height: _height,
      child: CustomPaint(
        painter: const JoinedShapePainter(
          lobes: _lobes,
          neck: _neck,
          fill: UiColors.surface,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final left = constraints.maxWidth * _split;
            return Stack(
              children: [
                Positioned(
                  left: 22,
                  width: left - 32,
                  top: 28,
                  child: _figure(
                    primaryValue,
                    primaryLabel,
                    valueStyle,
                    labelStyle,
                  ),
                ),
                Positioned(
                  left: left + 8,
                  right: 18,
                  top: 28,
                  child: _figure(
                    secondaryValue,
                    secondaryLabel,
                    secondaryStyle,
                    labelStyle,
                  ),
                ),
                if (onAdd != null)
                  Positioned(
                    right: 12,
                    top: 12,
                    child: _AddButton(
                      enabled: addEnabled,
                      label: addLabel,
                      onTap: onAdd!,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _figure(
    String value,
    String label,
    TextStyle valueStyle,
    TextStyle labelStyle,
  ) {
    return Semantics(
      container: true,
      label: '$value, $label',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(value, maxLines: 1, style: valueStyle),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.enabled,
    required this.label,
    required this.onTap,
  });

  final bool enabled;
  final String label;
  final VoidCallback onTap;

  static const Color _mutedIcon = Color(0xFFABABAB);

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: enabled ? onTap : null,
      semanticLabel: enabled ? label : '$label, no disponible todavía',
      child: Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? UiColors.lavender : UiColors.soft,
          shape: BoxShape.circle,
        ),
        child: Icon(
          UiIcons.plus,
          size: 24,
          color: enabled ? UiColors.ink : _mutedIcon,
        ),
      ),
    );
  }
}
