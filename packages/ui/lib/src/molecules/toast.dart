import 'dart:async';

import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// The five Toast variants of PRD-ux-spec.md section 8. Each has its own icon
/// so the meaning never depends on color alone.
enum UiToastVariant {
  neutral(
    background: UiColors.ink,
    circle: UiColors.chartreuse,
    icon: UiIcons.undo,
    iconColor: UiColors.ink,
    title: UiColors.surface,
    detail: Color(0xB3FFFFFF),
  ),
  success(
    background: UiColors.chartreuse,
    circle: UiColors.ink,
    icon: UiIcons.check,
    iconColor: UiColors.chartreuse,
    title: UiColors.ink,
    detail: Color(0xB3212121),
  ),
  info(
    background: UiColors.lavender,
    circle: UiColors.surface,
    icon: UiIcons.info,
    iconColor: UiColors.ink,
    title: UiColors.ink,
    detail: Color(0xB3212121),
  ),
  warning(
    background: UiColors.warning,
    circle: UiColors.ink,
    icon: UiIcons.warning,
    iconColor: UiColors.warning,
    title: UiColors.ink,
    detail: Color(0xB3212121),
  ),
  error(
    background: UiColors.danger,
    circle: UiColors.surface,
    icon: UiIcons.error,
    iconColor: UiColors.danger,
    title: UiColors.surface,
    detail: UiColors.surface,
  );

  const UiToastVariant({
    required this.background,
    required this.circle,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.detail,
  });

  final Color background;
  final Color circle;
  final IconData icon;
  final Color iconColor;
  final Color title;
  final Color detail;
}

/// Toast capsule (350 x 64, radius 32). Only the Neutral variant shows an
/// action; it is drawn in chartreuse on `ink`.
class UiToast extends StatelessWidget {
  const UiToast({
    required this.variant,
    required this.title,
    required this.detail,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final UiToastVariant variant;
  final String title;
  final String detail;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final showAction =
        variant == UiToastVariant.neutral && actionLabel != null;
    return Semantics(
      liveRegion: true,
      container: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: UiSizes.toastWidth),
        child: Container(
          height: UiSizes.toastHeight,
          padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
          decoration: BoxDecoration(
            color: variant.background,
            borderRadius: BorderRadius.circular(UiRadius.toast),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: variant.circle,
                  shape: BoxShape.circle,
                ),
                child: Icon(variant.icon, size: 18, color: variant.iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(15,
                          weight: 500, color: variant.title),
                    ),
                    Text(
                      detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(12, color: variant.detail),
                    ),
                  ],
                ),
              ),
              if (showAction) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onAction,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: UiSizes.touchTarget,
                      minWidth: UiSizes.touchTarget,
                    ),
                    child: Center(
                      widthFactor: 1,
                      child: Text(
                        actionLabel!,
                        style: UiTypography.custom(14,
                            weight: 500, color: UiColors.chartreuse),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

OverlayEntry? _currentToast;
Timer? _toastTimer;

void _removeToast() {
  _toastTimer?.cancel();
  _toastTimer = null;
  _currentToast?.remove();
  _currentToast = null;
}

/// Shows a toast over the current screen. Only one toast is visible at a time:
/// a new one replaces the previous. It dismisses itself after [duration]
/// (4 s) and can be swiped away horizontally. It never blocks the screen.
void showUiToast(
  BuildContext context, {
  required UiToastVariant variant,
  required String title,
  required String detail,
  String? actionLabel,
  VoidCallback? onAction,
  double bottomOffset = 24,
  Duration duration = const Duration(seconds: 4),
}) {
  final overlay = Overlay.of(context);
  _removeToast();

  final dismissKey = UniqueKey();
  final entry = OverlayEntry(
    builder: (overlayContext) => Positioned(
      left: 0,
      right: 0,
      bottom: bottomOffset + MediaQuery.of(overlayContext).padding.bottom,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: Dismissible(
            key: dismissKey,
            direction: DismissDirection.horizontal,
            onDismissed: (_) => _removeToast(),
            child: UiToast(
              variant: variant,
              title: title,
              detail: detail,
              actionLabel: actionLabel,
              onAction: onAction == null
                  ? null
                  : () {
                      onAction();
                      _removeToast();
                    },
            ),
          ),
        ),
      ),
    ),
  );
  _currentToast = entry;
  overlay.insert(entry);
  _toastTimer = Timer(duration, _removeToast);
}

/// Dismisses the visible toast, if any.
void hideUiToast() => _removeToast();
