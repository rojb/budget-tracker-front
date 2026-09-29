import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Swipe-to-confirm bar (PRD-ux-spec.md section 8).
///
/// The chartreuse handle is dragged to the check at the far end; releasing past
/// the threshold calls [onConfirm], releasing early snaps the handle back.
/// Tapping the handle also confirms (accessible alternative to the gesture).
/// When [enabled] is false the handle shows a lock, the label turns muted, the
/// end check drops to 40% opacity and nothing confirms. The calculator button
/// always calls [onCalculatorPressed].
class UiSaveBar extends StatefulWidget {
  const UiSaveBar({
    required this.label,
    required this.onConfirm,
    this.onCalculatorPressed,
    this.leadingIcon = UiIcons.calculator,
    this.enabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onConfirm;
  final VoidCallback? onCalculatorPressed;
  final IconData leadingIcon;
  final bool enabled;

  @override
  State<UiSaveBar> createState() => _UiSaveBarState();
}

class _UiSaveBarState extends State<UiSaveBar> {
  static const double _knob = 68;
  static const double _handle = 64;
  static const double _end = 52;
  static const double _endPad = 8;
  static const double _threshold = 0.8;

  double _dx = 0;
  bool _dragging = false;

  void _confirm() {
    if (widget.enabled) widget.onConfirm();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: UiSizes.saveBarWidth),
      child: SizedBox(
        height: UiSizes.saveBarHeight,
        child: LayoutBuilder(builder: (context, box) {
          final width = box.maxWidth;
          final endCenter = width - _endPad - _end / 2;
          final travel = (endCenter - _handle / 2) - _knob;
          final dx = _dx.clamp(0.0, travel);
          return Container(
            decoration: BoxDecoration(
              color: UiColors.soft,
              borderRadius: BorderRadius.circular(UiSizes.saveBarHeight / 2),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: _knob + _handle + 8,
                  right: _endPad + _end + 8,
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(
                        16,
                        weight: 500,
                        color: enabled ? UiColors.ink : UiColors.inkMuted,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: _endPad,
                  top: (UiSizes.saveBarHeight - _end) / 2,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.4,
                    child: _circle(_end, UiColors.surface, UiIcons.check,
                        UiColors.inkMuted, 18),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Semantics(
                    button: true,
                    label: 'Calculadora',
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.onCalculatorPressed,
                      child: _circle(
                        _knob,
                        enabled ? UiColors.ink : UiColors.disabledKnob,
                        widget.leadingIcon,
                        UiColors.surface,
                        22,
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration:
                      _dragging ? Duration.zero : const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  left: _knob + dx,
                  top: (UiSizes.saveBarHeight - _handle) / 2,
                  child: Semantics(
                    button: true,
                    enabled: enabled,
                    label: enabled
                        ? 'Confirmar: ${widget.label}'
                        : 'Deshabilitado: ${widget.label}',
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: enabled ? _confirm : null,
                      onHorizontalDragStart:
                          enabled ? (_) => setState(() => _dragging = true) : null,
                      onHorizontalDragUpdate: enabled
                          ? (d) => setState(() => _dx += d.delta.dx)
                          : null,
                      onHorizontalDragEnd: enabled
                          ? (_) {
                              final confirmed = dx >= travel * _threshold;
                              setState(() {
                                _dragging = false;
                                _dx = 0;
                              });
                              if (confirmed) _confirm();
                            }
                          : null,
                      onHorizontalDragCancel: enabled
                          ? () => setState(() {
                                _dragging = false;
                                _dx = 0;
                              })
                          : null,
                      child: _circle(
                        _handle,
                        enabled ? UiColors.chartreuse : UiColors.disabledHandle,
                        enabled ? UiIcons.check : UiIcons.lock,
                        enabled ? UiColors.ink : UiColors.inkMuted,
                        22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _circle(double size, Color bg, IconData icon, Color fg, double iconSize) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, size: iconSize, color: fg),
    );
  }
}
