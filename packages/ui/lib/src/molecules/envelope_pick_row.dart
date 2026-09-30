import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../atoms/selection_mark.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Bare icon plus name of the list rows of 35 and 46 (no circle, no card).
class _PickRow extends StatelessWidget {
  const _PickRow({
    required this.icon,
    required this.name,
    required this.trailing,
    required this.label,
    required this.onTap,
    this.selected,
  });

  final IconData icon;
  final String name;
  final Widget trailing;
  final String label;
  final VoidCallback? onTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      selected: selected,
      minWidth: 0,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 54,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(width: 14),
              Icon(icon, size: 22, color: UiColors.ink),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(18),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

/// Envelope row of 35 Plantilla sugerida: icon, name and a lavender check
/// circle when ticked (an outlined circle when not). Reports taps only.
class UiEnvelopeTickRow extends StatelessWidget {
  const UiEnvelopeTickRow({
    required this.icon,
    required this.name,
    required this.ticked,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String name;
  final bool ticked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _PickRow(
      icon: icon,
      name: name,
      label: name,
      selected: ticked,
      onTap: onTap,
      trailing: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ticked ? UiColors.lavender : null,
          shape: BoxShape.circle,
          border: ticked
              ? null
              : Border.all(color: const Color(0xFFD0D0D0), width: 1.5),
        ),
        child: ticked
            ? const Icon(UiIcons.check, size: 16, color: UiColors.ink)
            : null,
      ),
    );
  }
}

/// Envelope row of 36 Elegir sobre: icon circle (tinted red when overspent),
/// name, group, the available amount with its caption ("Disponible",
/// "Sobregirado") and the selection mark. Reports taps only.
class UiEnvelopePickRow extends StatelessWidget {
  const UiEnvelopePickRow({
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.amount,
    required this.caption,
    required this.selected,
    required this.onTap,
    this.overspent = false,
    super.key,
  });

  final IconData icon;
  final String name;

  /// Group of the envelope, e.g. "Día a día".
  final String subtitle;

  /// Formatted available amount ("$ 47.550", "−$ 6.200").
  final String amount;
  final String caption;
  final bool selected;
  final VoidCallback? onTap;

  /// Red icon circle, amount and caption: never by color alone, the caption
  /// says "Sobregirado".
  final bool overspent;

  @override
  Widget build(BuildContext context) {
    final tone = overspent ? UiColors.danger : UiColors.ink;
    return UiHitTarget(
      onTap: onTap,
      selected: selected,
      semanticLabel: '$name, $subtitle, $amount, $caption',
      minWidth: 0,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 76,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: overspent ? UiColors.dangerSoft : UiColors.bg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 21, color: tone),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(14, color: UiColors.inkMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: UiTypography.custom(17, weight: 500, color: tone),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    caption,
                    style: UiTypography.custom(
                      13,
                      color: overspent ? UiColors.danger : UiColors.inkMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              UiSelectionMark(selected: selected, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Envelope row of 46 Asigná tu dinero: icon, name and an amount pill (lavender
/// outline with the amount, or a muted "$ 0" when nothing is entered). Tapping
/// the row edits the amount.
class UiEnvelopeAmountRow extends StatelessWidget {
  const UiEnvelopeAmountRow({
    required this.icon,
    required this.name,
    required this.amount,
    required this.assigned,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String name;

  /// Formatted amount, e.g. "$ 280.000".
  final String amount;

  /// False draws the pill muted (nothing entered yet).
  final bool assigned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _PickRow(
      icon: icon,
      name: name,
      label: '$name, $amount',
      onTap: onTap,
      trailing: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: assigned ? UiColors.lavender : const Color(0xFFD0D0D0),
            width: 1.5,
          ),
        ),
        child: Text(
          amount,
          style: UiTypography.custom(
            17,
            color: assigned ? UiColors.ink : UiColors.inkMuted,
          ),
        ),
      ),
    );
  }
}
