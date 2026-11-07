import 'package:flutter/widgets.dart';

/// Horizontal scroller for [UiChip]s (PRD-ux-spec.md section 8, `ChipRow`).
///
/// Leaves [trailingPadding] after the last chip so it can scroll fully clear of
/// the screen edge, and fades the right edge while more chips are out of view.
/// The fade disappears once the end of the row is reached or when everything
/// fits. The row has no leading padding: the screen decides its own gutter.
class UiChipRow extends StatefulWidget {
  const UiChipRow({
    required this.children,
    this.spacing = 8,
    this.trailingPadding = 20,
    super.key,
  });

  final List<Widget> children;

  /// Gap between two chips.
  final double spacing;

  /// Space kept after the last chip.
  final double trailingPadding;

  @override
  State<UiChipRow> createState() => _UiChipRowState();
}

class _UiChipRowState extends State<UiChipRow> {
  static const double _fadeWidth = 32;

  final ScrollController _controller = ScrollController();
  bool _moreToTheRight = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_sync);
    // The extent is only known after the first layout.
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void didUpdateWidget(UiChipRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_sync)
      ..dispose();
    super.dispose();
  }

  void _sync() {
    if (!mounted || !_controller.hasClients) return;
    final position = _controller.position;
    final more = position.pixels < position.maxScrollExtent - 0.5;
    if (more != _moreToTheRight) setState(() => _moreToTheRight = more);
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (var i = 0; i < widget.children.length; i++) {
      if (i > 0) items.add(SizedBox(width: widget.spacing));
      items.add(widget.children[i]);
    }
    final row = SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: EdgeInsetsDirectional.only(end: widget.trailingPadding),
      child: Row(children: items),
    );
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) {
        // Fully opaque mask when nothing is hidden on the right.
        final fade = _moreToTheRight && bounds.width > _fadeWidth
            ? _fadeWidth / bounds.width
            : null;
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: fade == null
              ? const [Color(0xFF000000), Color(0xFF000000)]
              : const [Color(0xFF000000), Color(0xFF000000), Color(0x00000000)],
          stops: fade == null ? null : [0, 1 - fade, 1],
        ).createShader(bounds);
      },
      child: row,
    );
  }
}
