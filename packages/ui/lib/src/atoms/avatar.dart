import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Lavender circle with the person's initials.
class UiAvatar extends StatelessWidget {
  const UiAvatar({required this.initials, this.size = UiSizes.avatar, super.key});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: UiColors.lavender,
        shape: BoxShape.circle,
      ),
      child: Text(initials, style: UiTypography.custom(17, weight: 500)),
    );
  }
}
