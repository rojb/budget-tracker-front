import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/joined_shape.dart';

enum UiNavTab {
  home(UiIcons.house, 'Inicio'),
  plan(UiIcons.wallet, 'Plan'),
  transactions(UiIcons.arrowLeftRight, 'Movimientos'),
  accounts(UiIcons.creditCard, 'Cuentas');

  const UiNavTab(this.icon, this.label);

  final IconData icon;
  final String label;
}

/// Bottom tab bar: four circular tabs and a chartreuse "+" action between
/// Plan and Movimientos, on a translucent glass tray. The active tab is `ink`
/// with a white icon. Holds no navigation logic: it reports taps.
class UiNavCluster extends StatelessWidget {
  const UiNavCluster({
    required this.activeTab,
    required this.onTabSelected,
    required this.onAddPressed,
    super.key,
  });

  final UiNavTab activeTab;
  final ValueChanged<UiNavTab> onTabSelected;
  final VoidCallback onAddPressed;

  static const double _tab = 60;
  static const double _add = 64;
  static const double _gap = 8;
  static const double _trayPad = 6;
  static const double _neck = 10;

  /// One tray lobe per circle, each [_trayPad] wider than its circle on both
  /// sides; circles are [_gap] apart so neighbouring lobes overlap and the
  /// outline pinches between them.
  static const List<double> _circleSizes = [_tab, _tab, _add, _tab, _tab];

  static List<JoinedLobe> _lobes(Size size) {
    final lobes = <JoinedLobe>[];
    var x = 0.0;
    for (final c in _circleSizes) {
      final w = c + _trayPad * 2;
      lobes.add(JoinedLobe(x: x, width: w, radius: w / 2));
      x += c + _gap;
    }
    return lobes;
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (final tab in UiNavTab.values) {
      if (children.isNotEmpty) children.add(const SizedBox(width: _gap));
      children.add(
        _circle(
          size: _tab,
          background: tab == activeTab ? UiColors.ink : UiColors.surface,
          icon: tab.icon,
          iconColor: tab == activeTab ? UiColors.surface : UiColors.ink,
          iconSize: 22,
          label: tab.label,
          selected: tab == activeTab,
          onTap: () => onTabSelected(tab),
        ),
      );
      if (tab == UiNavTab.plan) {
        children
          ..add(const SizedBox(width: _gap))
          ..add(
            _circle(
              size: _add,
              background: UiColors.chartreuse,
              icon: UiIcons.plus,
              iconColor: UiColors.ink,
              iconSize: 24,
              label: 'Agregar',
              onTap: onAddPressed,
            ),
          );
      }
    }

    return CustomPaint(
      painter: const JoinedShapePainter(
        lobes: _lobes,
        neck: _neck,
        shadow: BoxShadow(
          color: Color(0x1F000000),
          offset: Offset(0, 8),
          blurRadius: 24,
        ),
      ),
      child: ClipPath(
        clipper: const JoinedShapeClipper(lobes: _lobes, neck: _neck),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: CustomPaint(
            painter: const JoinedShapePainter(
              lobes: _lobes,
              neck: _neck,
              fill: UiColors.trayFill,
              stroke: UiColors.trayBorder,
            ),
            child: Padding(
              padding: const EdgeInsets.all(_trayPad),
              child: Row(mainAxisSize: MainAxisSize.min, children: children),
            ),
          ),
        ),
      ),
    );
  }

  Widget _circle({
    required double size,
    required Color background,
    required IconData icon,
    required Color iconColor,
    required double iconSize,
    required String label,
    required VoidCallback onTap,
    bool? selected,
  }) {
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      selected: selected,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
