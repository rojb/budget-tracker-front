import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Two- or three-segment control (Gasto / Ingreso by default; Todos / Gastos /
/// Ingresos in 11). Controlled: the parent owns the selection and rebuilds with
/// the new [selectedIndex].
class UiToggle extends StatelessWidget {
  const UiToggle({
    required this.selectedIndex,
    required this.onChanged,
    this.labels = const ['Gasto', 'Ingreso'],
    super.key,
  }) : assert(
         labels.length == 2 || labels.length == 3,
         'Toggle has two or three segments',
       );

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UiSizes.toggleHeight,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: UiColors.soft,
        borderRadius: BorderRadius.circular(UiSizes.toggleHeight / 2),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Expanded(
              child: _Segment(
                label: labels[i],
                active: i == selectedIndex,
                onTap: () => onChanged(i),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? UiColors.lavender : null,
            borderRadius: BorderRadius.circular(22),
          ),
          child: ExcludeSemantics(
            child: Text(
              label,
              style: UiTypography.custom(15, weight: active ? 500 : 400),
            ),
          ),
        ),
      ),
    );
  }
}
