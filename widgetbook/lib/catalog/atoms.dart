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
            name: 'white and danger (confirmation sheet)',
            builder: (context) => stage(
              SizedBox(
                width: 340,
                child: Row(
                  children: [
                    Expanded(
                      child: UiButton(
                        label: 'Cancelar',
                        variant: UiButtonVariant.white,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: UiButton(
                        label: 'Archivar',
                        variant: UiButtonVariant.danger,
                        onPressed: () {},
                      ),
                    ),
                  ],
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
            name: 'soft compact (on a white card, 06)',
            builder: (context) => stage(
              Container(
                padding: const EdgeInsets.all(16),
                color: UiColors.surface,
                child: const Wrap(
                  spacing: 8,
                  children: [
                    UiChip(
                      label: 'Alquiler',
                      soft: true,
                      size: UiChipSize.compact,
                    ),
                    UiChip(label: '+8', soft: true, size: UiChipSize.compact),
                  ],
                ),
              ),
            ),
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
        name: 'FormMessage',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(
              const SizedBox(
                width: 350,
                child: UiFormMessage(
                  message: 'Email o contraseña incorrectos. Revisalos e intentá de nuevo.',
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'LinkRow',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(
              SizedBox(
                width: 350,
                child: UiLinkRow(
                  prompt: '¿No tenés cuenta?',
                  actionLabel: 'Crear cuenta',
                  onPressed: () {},
                ),
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
      WidgetbookComponent(
        name: 'InfoNote',
        useCases: [
          WidgetbookUseCase(
            name: 'plain',
            builder: (context) => stage(
              const SizedBox(
                width: 350,
                child: UiInfoNote(
                  text:
                      'Esto es lo que tenés, no lo que podés gastar. Lo gastable '
                      'está en tus sobres.',
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'lavender',
            builder: (context) => stage(
              const SizedBox(
                width: 350,
                child: UiInfoNote(
                  variant: UiInfoNoteVariant.lavender,
                  icon: UiIcons.cornerDownRight,
                  title: 'Deja de sumar al saldo total.',
                  text: 'Sus movimientos se conservan.',
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'StripeBar',
        useCases: [
          for (final value in [0.84, 0.12, 0.04, 1.0, 0.0])
            WidgetbookUseCase(
              name: '${(value * 100).round()} %',
              builder: (context) =>
                  stage(SizedBox(width: 360, child: UiStripeBar(value: value))),
            ),
        ],
      ),
      WidgetbookComponent(
        name: 'ChecklistRow',
        useCases: [
          WidgetbookUseCase(
            name: 'done, pending, disabled',
            builder: (context) => stage(
              Container(
                width: 380,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: UiColors.surface,
                  borderRadius: BorderRadius.circular(UiRadius.card),
                ),
                child: Column(
                  children: [
                    const UiChecklistRow(
                      label: 'Creaste tu plan',
                      state: UiChecklistState.done,
                    ),
                    UiChecklistRow(
                      label: 'Agregá tus otras cuentas',
                      onTap: () {},
                    ),
                    UiChecklistRow(label: 'Creá tus sobres', onTap: () {}),
                    UiChecklistRow(
                      label: 'Asigná tu dinero',
                      state: UiChecklistState.disabled,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
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
