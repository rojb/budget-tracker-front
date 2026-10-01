import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Icon selector of 31 Nuevo sobre and 23 Editar sobre: the first icons of the
/// API's closed set in one row and a "…" that expands the rest.
class EnvelopeIconSelector extends StatefulWidget {
  const EnvelopeIconSelector({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<EnvelopeIconSelector> createState() => _EnvelopeIconSelectorState();
}

class _EnvelopeIconSelectorState extends State<EnvelopeIconSelector> {
  /// Icons shown before the "…" button; the rest of the closed set follows it.
  static const int _visibleIcons = 6;

  bool _more = false;

  @override
  Widget build(BuildContext context) {
    final names = uiEnvelopeIcons.keys.toList();
    final shown = _more ? names : names.take(_visibleIcons).toList();
    final buttons = [
      for (final name in shown)
        UiIconButton(
          icon: uiEnvelopeIcons[name]!,
          variant: name == widget.selected
              ? UiIconButtonVariant.lavender
              : UiIconButtonVariant.white,
          size: 48,
          semanticLabel: 'Ícono $name',
          onPressed: () => widget.onSelected(name),
        ),
      if (!_more)
        UiIconButton(
          icon: UiIcons.ellipsis,
          size: 48,
          semanticLabel: 'Más íconos',
          onPressed: () => setState(() => _more = true),
        ),
    ];
    // One row of seven as in the design; the full set wraps once expanded.
    return _more
        ? Wrap(spacing: 8, runSpacing: 8, children: buttons)
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buttons,
          );
  }
}
