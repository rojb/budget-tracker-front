import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Form-level error line: a `danger` alert icon followed by the message, shown
/// under a form (screen 18 "Email o contraseña incorrectos"). Icon plus text so
/// the state is never conveyed by color alone.
class UiFormMessage extends StatelessWidget {
  const UiFormMessage({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: message,
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  UiIcons.circleAlert,
                  size: 18,
                  color: UiColors.danger,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: UiTypography.custom(15, color: UiColors.danger),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
