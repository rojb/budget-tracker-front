import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';

/// Selection indicator of the pickers (PRD-ux-spec.md 6.1 rule 9): a lavender
/// check circle when chosen, an empty radio outline otherwise. Internal to
/// `packages/ui`; the rows that host it expose `selected`.
class UiSelectionMark extends StatelessWidget {
  const UiSelectionMark({required this.selected, this.size = 32, super.key});

  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? UiColors.lavender : null,
        shape: BoxShape.circle,
        border: selected
            ? null
            : Border.all(color: const Color(0xFFD0D0D0), width: 1.5),
      ),
      child: selected
          ? Icon(UiIcons.check, size: size / 2, color: UiColors.ink)
          : null,
    );
  }
}
