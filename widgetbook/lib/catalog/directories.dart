import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// One component per `packages/ui` widget, grouped by atomic level.
final List<WidgetbookNode> directories = [
  WidgetbookFolder(
    name: 'atoms',
    children: [
      WidgetbookComponent(
        name: 'PlaceholderCard',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (BuildContext context) =>
                const PlaceholderCard(message: 'Placeholder story'),
          ),
        ],
      ),
    ],
  ),
];
