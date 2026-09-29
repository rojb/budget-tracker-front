import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Pill text field: 12 muted label above a 16/500 value, optional trailing
/// icon. Default (no border), Focus (1.5 lavender, applied on input focus) and
/// Error (1.5 danger plus a message below, so the state is not color only).
class UiTextField extends StatefulWidget {
  const UiTextField({
    required this.label,
    this.controller,
    this.focusNode,
    this.errorText,
    this.trailingIcon,
    this.onTrailingPressed,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
    this.autofillHints,
    this.autocorrect = true,
    this.enableSuggestions = true,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// When non-null the field is in the Error state and shows this message
  /// (an empty string keeps the Error border but shows no message line, for
  /// forms that render one shared message elsewhere).
  final String? errorText;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingPressed;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  /// Keyboard action button (next/done) and its callback.
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  /// Autofill hints for password managers, e.g. `AutofillHints.email`.
  final Iterable<String>? autofillHints;
  final bool autocorrect;
  final bool enableSuggestions;

  @override
  State<UiTextField> createState() => _UiTextFieldState();
}

class _UiTextFieldState extends State<UiTextField> {
  FocusNode? _ownedNode;

  FocusNode get _node => widget.focusNode ?? (_ownedNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _node.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(UiTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _ownedNode)?.removeListener(_onFocus);
      _node.addListener(_onFocus);
    }
  }

  @override
  void dispose() {
    _node.removeListener(_onFocus);
    _ownedNode?.dispose();
    super.dispose();
  }

  void _onFocus() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final Color? border = hasError
        ? UiColors.danger
        : (_node.hasFocus ? UiColors.lavender : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: UiSizes.textFieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: UiColors.surface,
            borderRadius: BorderRadius.circular(UiSizes.textFieldHeight / 2),
            border: border == null
                ? null
                : Border.all(color: border, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: UiTypography.custom(12, color: UiColors.inkMuted),
                    ),
                    TextField(
                      controller: widget.controller,
                      focusNode: _node,
                      obscureText: widget.obscureText,
                      keyboardType: widget.keyboardType,
                      onChanged: widget.onChanged,
                      textInputAction: widget.textInputAction,
                      onSubmitted: widget.onSubmitted,
                      autofillHints: widget.autofillHints,
                      autocorrect: widget.autocorrect,
                      enableSuggestions: widget.enableSuggestions,
                      cursorColor: UiColors.ink,
                      style: UiTypography.bodyStrong,
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ],
                ),
              ),
              if (widget.trailingIcon != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onTrailingPressed,
                  child: Icon(
                    widget.trailingIcon,
                    size: 18,
                    color: UiColors.ink,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (hasError && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 6),
            child: Text(
              widget.errorText!,
              style: UiTypography.custom(12, color: UiColors.danger),
            ),
          ),
      ],
    );
  }
}
