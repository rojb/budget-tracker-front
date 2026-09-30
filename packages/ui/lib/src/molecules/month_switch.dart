import 'package:flutter/widgets.dart';

import '../atoms/icon_button.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// "‹ Septiembre 2026 ›" control of the month views (02, 04, 06, 33): two white
/// round buttons around a white pill with the month. Reports taps only.
class UiMonthSwitch extends StatelessWidget {
  const UiMonthSwitch({
    required this.label,
    required this.onPrevious,
    required this.onNext,
    super.key,
  });

  final String label;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UiIconButton(
          icon: UiIcons.chevronLeft,
          onPressed: onPrevious,
          semanticLabel: 'Mes anterior',
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: UiColors.surface,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Semantics(
              liveRegion: true,
              child: Text(label, style: UiTypography.custom(19)),
            ),
          ),
        ),
        const SizedBox(width: 6),
        UiIconButton(
          icon: UiIcons.chevronRight,
          onPressed: onNext,
          semanticLabel: 'Mes siguiente',
        ),
      ],
    );
  }
}
