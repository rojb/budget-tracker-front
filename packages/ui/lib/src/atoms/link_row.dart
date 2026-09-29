import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';
import 'hit_target.dart';

/// Centered "prompt + action" row under auth forms:
/// "¿No tenés cuenta? **Crear cuenta**". Only the action is tappable (48 dp
/// hit area).
class UiLinkRow extends StatelessWidget {
  const UiLinkRow({
    required this.prompt,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            prompt,
            style: UiTypography.custom(16, color: UiColors.inkMuted),
          ),
        ),
        const SizedBox(width: 8),
        UiHitTarget(
          onTap: onPressed,
          semanticLabel: actionLabel,
          child: ExcludeSemantics(
            child: Text(
              actionLabel,
              style: UiTypography.custom(16, weight: 500),
            ),
          ),
        ),
      ],
    );
  }
}
