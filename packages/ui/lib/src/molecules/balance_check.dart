import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// The "Todo cuadra" card of 25 Cierre de mes: a [title], the invariant with
/// real numbers ("$ 1.000.000 − $ 938.000 − $ 20.000 = $ 42.000"), a mark
/// (chartreuse check when [balanced], warning triangle otherwise) and the
/// formula in words as a [caption].
class UiBalanceCheck extends StatelessWidget {
  const UiBalanceCheck({
    required this.title,
    required this.equation,
    required this.caption,
    this.balanced = true,
    super.key,
  });

  final String title;
  final String equation;
  final String caption;
  final bool balanced;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '$title, $equation, $caption',
      child: ExcludeSemantics(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 22, 16, 22),
          decoration: BoxDecoration(
            color: UiColors.surface,
            borderRadius: BorderRadius.circular(UiRadius.card),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: UiTypography.custom(18)),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(equation, style: UiTypography.custom(16)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: balanced ? UiColors.chartreuse : UiColors.warning,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      balanced ? UiIcons.check : UiIcons.warning,
                      size: 20,
                      color: UiColors.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                caption,
                style: UiTypography.custom(13, color: UiColors.inkMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
