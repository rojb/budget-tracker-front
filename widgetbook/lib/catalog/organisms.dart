import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stage.dart';

WidgetbookFolder organismsFolder() {
  return WidgetbookFolder(
    name: 'organisms',
    children: [
      WidgetbookComponent(
        name: 'NavCluster',
        useCases: [
          for (final tab in UiNavTab.values)
            WidgetbookUseCase(
              name: tab.label,
              builder: (context) => stage(
                UiNavCluster(
                  activeTab: tab,
                  onTabSelected: (_) {},
                  onAddPressed: () {},
                ),
              ),
            ),
        ],
      ),
      WidgetbookComponent(
        name: 'SaveBar',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(const _SaveBarDemo(enabled: true)),
          ),
          WidgetbookUseCase(
            name: 'disabled',
            builder: (context) => stage(const _SaveBarDemo(enabled: false)),
          ),
        ],
      ),
    ],
  );
}

class _SaveBarDemo extends StatefulWidget {
  const _SaveBarDemo({required this.enabled});

  final bool enabled;

  @override
  State<_SaveBarDemo> createState() => _SaveBarDemoState();
}

class _SaveBarDemoState extends State<_SaveBarDemo> {
  int _confirmed = 0;
  int _calculator = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 340,
          child: UiSaveBar(
            label: widget.enabled ? 'Guardar' : r'Faltan $ 500',
            enabled: widget.enabled,
            onConfirm: () => setState(() => _confirmed++),
            onCalculatorPressed: () => setState(() => _calculator++),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Confirmaciones: $_confirmed · Calculadora: $_calculator',
          style: UiTypography.caption,
        ),
      ],
    );
  }
}
