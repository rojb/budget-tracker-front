import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Desde / Hasta input of 11 Filtrar movimientos: a small muted label over the
/// value (or a muted [placeholder] while empty) and a trailing calendar or
/// clock icon. White pill; tapping it opens the matching date or time sheet.
class UiPickerField extends StatelessWidget {
  const UiPickerField({
    required this.label,
    required this.icon,
    this.value,
    this.placeholder = '—',
    this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;

  /// Formatted value ("01/09/2026", "18:00"); null shows [placeholder].
  final String? value;
  final String placeholder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final empty = value == null;
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: '$label: ${value ?? placeholder}',
      minWidth: 0,
      child: ExcludeSemantics(
        child: Container(
          height: UiSizes.textFieldHeight,
          padding: const EdgeInsets.only(left: 20, right: 18),
          decoration: BoxDecoration(
            color: UiColors.surface,
            borderRadius: BorderRadius.circular(UiSizes.textFieldHeight / 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: UiTypography.custom(13, color: UiColors.inkMuted),
                    ),
                    Text(
                      value ?? placeholder,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(
                        17,
                        color: empty ? UiColors.inkMuted : UiColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 22, color: UiColors.ink),
            ],
          ),
        ),
      ),
    );
  }
}
