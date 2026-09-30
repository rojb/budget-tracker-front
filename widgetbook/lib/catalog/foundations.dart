import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stage.dart';

WidgetbookFolder foundationsFolder() {
  return WidgetbookFolder(
    name: 'foundations',
    children: [
      WidgetbookComponent(
        name: 'Colors',
        useCases: [
          WidgetbookUseCase(
            name: 'tokens',
            builder: (context) => stage(_colors()),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Typography',
        useCases: [
          WidgetbookUseCase(
            name: 'scale',
            builder: (context) => stage(_typography()),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Icons',
        useCases: [
          WidgetbookUseCase(name: 'set', builder: (context) => stage(_icons())),
        ],
      ),
      WidgetbookComponent(
        name: 'Money',
        useCases: [
          WidgetbookUseCase(
            name: 'formatMoney',
            builder: (context) => stage(_money()),
          ),
        ],
      ),
    ],
  );
}

Widget _icons() {
  const icons = <String, IconData>{
    'house': UiIcons.house,
    'wallet': UiIcons.wallet,
    'arrowLeftRight': UiIcons.arrowLeftRight,
    'creditCard': UiIcons.creditCard,
    'plus': UiIcons.plus,
    'check': UiIcons.check,
    'calculator': UiIcons.calculator,
    'chevronLeft': UiIcons.chevronLeft,
    'chevronRight': UiIcons.chevronRight,
    'close': UiIcons.close,
    'search': UiIcons.search,
    'layers': UiIcons.layers,
    'pencil': UiIcons.pencil,
    'archive': UiIcons.archive,
    'landmark': UiIcons.landmark,
    'smartphone': UiIcons.smartphone,
    'banknote': UiIcons.banknote,
    'keyRound': UiIcons.keyRound,
    'contact': UiIcons.contact,
    'cornerDownRight': UiIcons.cornerDownRight,
    'wand': UiIcons.wand,
    'info': UiIcons.info,
    'logOut': UiIcons.logOut,
  };
  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      for (final e in icons.entries)
        SizedBox(
          width: 88,
          child: Column(
            children: [
              Icon(e.value, size: 24, color: UiColors.ink),
              const SizedBox(height: 6),
              Text(e.key, style: UiTypography.caption),
            ],
          ),
        ),
    ],
  );
}

Widget _colors() {
  const tokens = <String, Color>{
    'bg': UiColors.bg,
    'surface': UiColors.surface,
    'ink': UiColors.ink,
    'ink-muted': UiColors.inkMuted,
    'lavender': UiColors.lavender,
    'chartreuse': UiColors.chartreuse,
    'chartreuse-deep': UiColors.chartreuseDeep,
    'danger': UiColors.danger,
    'warning': UiColors.warning,
    'glass': UiColors.glass,
  };
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      for (final e in tokens.entries)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 96,
              height: 64,
              decoration: BoxDecoration(
                color: e.value,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: UiColors.soft),
              ),
            ),
            const SizedBox(height: 4),
            Text(e.key, style: UiTypography.caption),
          ],
        ),
    ],
  );
}

Widget _typography() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(r'$ 18.300', style: UiTypography.display),
      Text('Buenos días, Sofía', style: UiTypography.headline),
      Text('Día a día', style: UiTypography.title),
      Text('Supermercado', style: UiTypography.body),
      Text(r'$ 47.550', style: UiTypography.bodyStrong),
      Text('19:10 · Banco Nación', style: UiTypography.caption),
    ],
  );
}

Widget _money() {
  final lines = <(String, int, Currency)>[
    ('ARS 48200', 48200, Currency.ars),
    ('USD 125050', 125050, Currency.usd),
    ('EUR 98000', 98000, Currency.eur),
    ('USD -1250', -1250, Currency.usd),
    ('ARS 0', 0, Currency.ars),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final l in lines)
        labelled(
          l.$1,
          Text(formatMoney(l.$2, l.$3), style: UiTypography.title),
        ),
    ],
  );
}
