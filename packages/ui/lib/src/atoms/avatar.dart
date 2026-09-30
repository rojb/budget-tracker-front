import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Circle with the person's initials; lavender by default, [color] for a
/// second member (16 shows the other member in chartreuse).
class UiAvatar extends StatelessWidget {
  const UiAvatar({
    required this.initials,
    this.size = UiSizes.avatar,
    this.color = UiColors.lavender,
    super.key,
  });

  final String initials;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        initials,
        style: UiTypography.custom(size < 44 ? 14 : 17, weight: 500),
      ),
    );
  }
}
