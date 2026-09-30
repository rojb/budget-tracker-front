import 'package:flutter/material.dart';

import '../atoms/icon_button.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/typography.dart';

/// Bottom sheet body of the picker/confirmation pattern (PRD-ux-spec.md 9.3):
/// handle, optional title (24) with a 48 x 48 close button, then [child].
class UiSheet extends StatelessWidget {
  const UiSheet({
    required this.child,
    this.title,
    this.showClose = true,
    this.header,
    super.key,
  });

  final Widget child;
  final String? title;
  final bool showClose;

  /// Replaces the title row (e.g. 39's avatar, name and email).
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFD0D0D0),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 18),
          if (header != null || title != null || showClose)
            Row(
              children: [
                Expanded(
                  child:
                      header ??
                      (title == null
                          ? const SizedBox.shrink()
                          : Text(title!, style: UiTypography.custom(24))),
                ),
                if (showClose)
                  UiIconButton(
                    icon: UiIcons.close,
                    size: 48,
                    variant: UiIconButtonVariant.soft,
                    semanticLabel: 'Cerrar',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
              ],
            ),
          const SizedBox(height: 16),
          Flexible(child: child),
        ],
      ),
    );
  }
}

/// Shows [UiSheet] content as a modal bottom sheet over a dimmed background.
Future<T?> showUiSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: UiColors.bg,
    barrierColor: const Color(0x66000000),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: builder,
  );
}
