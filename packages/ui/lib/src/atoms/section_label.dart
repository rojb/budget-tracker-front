import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Selector divider label (PRD-ux-spec.md section 8, "Los tres estilos de
/// etiqueta de grupo", style 2): 12 / 600, `ink-muted`, uppercase, no action
/// (35 Plantilla sugerida, 46 Asigná tu dinero, the pickers 26, 36, 37).
class UiSectionLabel extends StatelessWidget {
  const UiSectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 4),
        child: Text(
          label.toUpperCase(),
          style: UiTypography.custom(12, weight: 600, color: UiColors.inkMuted),
        ),
      ),
    );
  }
}
