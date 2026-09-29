import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stage.dart';

WidgetbookFolder atomsFolder() {
  return WidgetbookFolder(
    name: 'atoms',
    children: [
      WidgetbookComponent(
        name: 'IconButton',
        useCases: [
          for (final v in UiIconButtonVariant.values)
            WidgetbookUseCase(
              name: v.name,
              builder: (context) => stage(
                // Glass is white on transparent: show it over a dark surface.
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: v == UiIconButtonVariant.glass
                        ? UiColors.inkMuted
                        : null,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: UiIconButton(
                    icon: UiIcons.star,
                    variant: v,
                    semanticLabel: 'Favorito',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
        ],
      ),
      WidgetbookComponent(
        name: 'Button',
        useCases: [
          WidgetbookUseCase(
            name: 'primary',
            builder: (context) => stage(
              SizedBox(
                width: 340,
                child: UiButton(
                  label: 'Guardar',
                  icon: UiIcons.sparkles,
                  onPressed: () {},
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'secondary',
            builder: (context) => stage(
              SizedBox(
                width: 340,
                child: UiButton(
                  label: 'Crear sobre vacío',
                  icon: UiIcons.plus,
                  variant: UiButtonVariant.secondary,
                  onPressed: () {},
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'primary loading',
            builder: (context) => stage(
              SizedBox(
                width: 340,
                child: UiButton(
                  label: 'Entrar',
                  loading: true,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Chip',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) =>
                stage(UiChip(label: 'Chip', onPressed: () {})),
          ),
          WidgetbookUseCase(
            name: 'selected',
            builder: (context) =>
                stage(UiChip(label: 'Chip', selected: true, onPressed: () {})),
          ),
          WidgetbookUseCase(
            name: 'defaultIcon',
            builder: (context) =>
                stage(UiChip(label: 'Chip', showCheck: true, onPressed: () {})),
          ),
          WidgetbookUseCase(
            name: 'compact (34)',
            builder: (context) => stage(
              UiChip(
                label: 'Alquiler',
                size: UiChipSize.compact,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Avatar',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(const UiAvatar(initials: 'SO')),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Key',
        useCases: [
          WidgetbookUseCase(
            name: 'number',
            builder: (context) => stage(UiKey(label: '5', onPressed: () {})),
          ),
          WidgetbookUseCase(
            name: 'operator',
            builder: (context) => stage(
              UiKey(
                label: '+',
                variant: UiKeyVariant.operator,
                onPressed: () {},
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'del',
            builder: (context) =>
                stage(UiKey(variant: UiKeyVariant.del, onPressed: () {})),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Toggle',
        useCases: [
          WidgetbookUseCase(
            name: 'gastoActive',
            builder: (context) => stage(const _ToggleDemo(initial: 0)),
          ),
          WidgetbookUseCase(
            name: 'ingresoActive',
            builder: (context) => stage(const _ToggleDemo(initial: 1)),
          ),
        ],
      ),
    ],
  );
}

class _ToggleDemo extends StatefulWidget {
  const _ToggleDemo({required this.initial});

  final int initial;

  @override
  State<_ToggleDemo> createState() => _ToggleDemoState();
}

class _ToggleDemoState extends State<_ToggleDemo> {
  late int _index = widget.initial;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: UiToggle(
        selectedIndex: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}
