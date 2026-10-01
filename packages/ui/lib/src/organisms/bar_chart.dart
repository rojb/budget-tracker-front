import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// One bar of [UiBarChart].
class UiBarChartEntry {
  const UiBarChartEntry({
    required this.label,
    required this.value,
    required this.semanticLabel,
  });

  /// Short label under the bar ("Sep").
  final String label;

  /// Height of the bar, relative to the largest value of the chart; values
  /// below zero draw as zero.
  final num value;

  /// What a screen reader says for the bar ("Septiembre, $ 264.550").
  final String semanticLabel;
}

/// The bar chart of 17 Reportes: one series, one bar per month on a white
/// card. Bars are `soft` with rounded ends; the selected one is drawn in
/// chartreuse stripes with [selectedValue] in an `ink` pill above it and its
/// label in `ink`. Each bar is a tap target that selects it. A single series
/// needs no legend: the screen's figure and label name it.
class UiBarChart extends StatelessWidget {
  const UiBarChart({
    required this.entries,
    required this.selectedIndex,
    required this.selectedValue,
    required this.onSelected,
    this.height = 300,
    super.key,
  });

  final List<UiBarChartEntry> entries;
  final int selectedIndex;

  /// Short value of the selected bar ("$ 265k").
  final String selectedValue;
  final ValueChanged<int> onSelected;
  final double height;

  static const double _pill = 40;
  static const double _labels = 34;

  @override
  Widget build(BuildContext context) {
    final maxValue = entries.fold<num>(0, (m, e) => math.max(m, e.value));
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      decoration: BoxDecoration(
        color: UiColors.surface,
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: LayoutBuilder(
        builder: (context, box) {
          final plot = box.maxHeight - _pill - _labels;
          final gap = entries.length > 8 ? 6.0 : 12.0;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < entries.length; i++) ...[
                if (i > 0) SizedBox(width: gap),
                Expanded(
                  child: _Bar(
                    entry: entries[i],
                    selected: i == selectedIndex,
                    selectedValue: selectedValue,
                    barHeight: maxValue <= 0
                        ? 12
                        : math.max(
                            12,
                            plot * math.max(0, entries[i].value) / maxValue,
                          ),
                    pillHeight: _pill,
                    labelHeight: _labels,
                    onTap: () => onSelected(i),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.entry,
    required this.selected,
    required this.selectedValue,
    required this.barHeight,
    required this.pillHeight,
    required this.labelHeight,
    required this.onTap,
  });

  final UiBarChartEntry entry;
  final bool selected;
  final String selectedValue;
  final double barHeight;
  final double pillHeight;
  final double labelHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return UiHitTarget(
      onTap: onTap,
      selected: selected,
      semanticLabel: entry.semanticLabel,
      minWidth: 0,
      child: ExcludeSemantics(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: pillHeight,
              child: selected
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: OverflowBox(
                        maxWidth: 120,
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: UiColors.ink,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            widthFactor: 1,
                            child: Text(
                              selectedValue,
                              style: UiTypography.custom(
                                13,
                                weight: 500,
                                color: UiColors.surface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: barHeight,
                width: double.infinity,
                child: selected
                    ? const CustomPaint(painter: _StripesPainter())
                    : const ColoredBox(color: UiColors.soft),
              ),
            ),
            SizedBox(
              height: labelHeight,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  entry.label,
                  maxLines: 1,
                  style: UiTypography.custom(
                    14,
                    weight: selected ? 500 : 400,
                    color: selected ? UiColors.ink : UiColors.inkMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vertical chartreuse stripes of the selected bar.
class _StripesPainter extends CustomPainter {
  const _StripesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = UiColors.chartreuse.withValues(alpha: 0.45),
    );
    final stripe = Paint()..color = UiColors.chartreuseDeep;
    for (var x = 3.0; x < size.width; x += 7) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 0, 3.5, size.height),
          const Radius.circular(2),
        ),
        stripe,
      );
    }
  }

  @override
  bool shouldRepaint(_StripesPainter oldDelegate) => false;
}
