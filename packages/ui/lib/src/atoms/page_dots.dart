import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';

/// Page indicator of the goals carousel (01): one short mark per page, the
/// selected one `ink` and longer, the others `ink-muted` at low alpha.
class UiPageDots extends StatelessWidget {
  const UiPageDots({required this.count, required this.index, super.key});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Página ${index + 1} de $count',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < count; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: EdgeInsets.only(left: i == 0 ? 0 : 5),
                width: i == index ? 36 : 12,
                height: 5,
                decoration: BoxDecoration(
                  color: i == index
                      ? UiColors.ink
                      : UiColors.inkMuted.withAlpha(70),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
