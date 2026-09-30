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
      WidgetbookComponent(
        name: 'JoinedCard',
        useCases: [
          WidgetbookUseCase(
            name: 'cuentas (13)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiJoinedCard(
                  primaryValue: formatMoney(1000000, Currency.ars),
                  primaryLabel: 'Saldo total',
                  secondaryValue: '3',
                  secondaryLabel: 'Cuentas',
                  addLabel: 'Nueva cuenta',
                  onAdd: () {},
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'plan vacío, "+" muted (06)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiJoinedCard(
                  primaryValue: formatMoney(300000, Currency.ars),
                  primaryLabel: 'Listo para asignar',
                  secondaryValue: '0',
                  secondaryLabel: 'Sobres activos',
                  addEnabled: false,
                  addLabel: 'Asignar dinero',
                  onAdd: () {},
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'plan en dólares (33)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiJoinedCard(
                  primaryValue: formatMoney(50000, Currency.usd),
                  primaryLabel: 'Listo para asignar',
                  secondaryValue: '3',
                  secondaryLabel: 'Sobres activos',
                  addLabel: 'Asignar dinero',
                  onAdd: () {},
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'two amounts (14)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiJoinedCard(
                  primaryValue: formatMoney(850000, Currency.ars),
                  primaryLabel: 'Entró en sep',
                  secondaryValue: formatMoney(307700, Currency.ars),
                  secondaryLabel: 'Salió',
                  secondaryIsAmount: true,
                ),
              ),
            ),
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
