import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stage.dart';

/// The compositions of 22, 24 and 31 built from `packages/ui` widgets, drawn at
/// the text scales 1.0, 1.3 and 2.0 to look for clipped text, overflow stripes
/// and an unreachable `SaveBar`. The scale is forced here with a `MediaQuery`;
/// no device setting changes.
WidgetbookComponent textScaleComponent() {
  return WidgetbookComponent(
    name: 'TextScale',
    useCases: [
      for (final scale in const [1.0, 1.3, 2.0]) ...[
        WidgetbookUseCase(
          name: '22 Detalle de sobre · ×$scale',
          builder: (context) => _frame(scale, const _EnvelopeDetail()),
        ),
        WidgetbookUseCase(
          name: '24 Mover dinero · ×$scale',
          builder: (context) => _frame(scale, const _MoveMoney()),
        ),
        WidgetbookUseCase(
          name: '31 Nuevo sobre · ×$scale',
          builder: (context) => _frame(scale, const _NewEnvelope()),
        ),
      ],
    ],
  );
}

Widget _frame(double scale, Widget child) {
  return Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(scale)),
      child: stage(
        SizedBox(width: 393, child: SingleChildScrollView(child: child)),
      ),
    ),
  );
}

class _EnvelopeDetail extends StatelessWidget {
  const _EnvelopeDetail();

  Widget _figure(
    String value,
    String label, {
    bool emphasized = false,
    bool muted = false,
  }) => Expanded(
    flex: emphasized ? 13 : 10,
    child: Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: UiTypography.custom(
              emphasized ? 34 : 24,
              weight: 300,
              color: muted ? UiColors.inkMuted : UiColors.ink,
            ),
          ),
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: UiTypography.custom(15, color: UiColors.inkMuted),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            children: [
              _figure(r'$ 400.000', 'Asignado'),
              const SizedBox(width: 12),
              _figure(r'$ 316.800', 'Disponible', emphasized: true),
              const SizedBox(width: 12),
              _figure(r'$ 83.200', 'Gastado', muted: true),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const UiCard(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              UiTxRow(
                icon: UiIcons.arrowLeftRight,
                title: 'Movido a Salidas con un nombre largo',
                subtitle: '21:52',
                amount: r'−$ 10.000',
                titleMaxLines: 1,
              ),
              UiTxRow(
                icon: UiIcons.cart,
                title: 'Supermercado',
                subtitle: 'Sin sobre · 15:04',
                amount: r'−$ 20.000',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoveMoney extends StatelessWidget {
  const _MoveMoney();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const UiEnvelopeRow(
          icon: UiIcons.cart,
          name: 'Supermercado',
          subtitle: r'$ 83.200 de $ 400.000',
          amount: r'$ 316.800',
        ),
        const SizedBox(height: 10),
        const UiEnvelopeRow(
          icon: UiIcons.bus,
          name: 'Transporte',
          variant: UiEnvelopeRowVariant.overspent,
          subtitle: r'$ 56.200 de $ 50.000',
          amount: r'−$ 6.200',
        ),
        const SizedBox(height: 22),
        const Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: UiAmountCapsule(symbol: r'$', value: '1.234.567'),
          ),
        ),
        const SizedBox(height: 16),
        // The three fixed slots of 24; the cover slot holds a long amount.
        const Row(
          children: [
            Expanded(child: UiChip(label: '1.234.567', selected: true)),
            SizedBox(width: 8),
            Expanded(child: UiChip(label: '10.000')),
            SizedBox(width: 8),
            Expanded(child: UiChip(label: '20.000')),
          ],
        ),
        const SizedBox(height: 22),
        UiSaveBar(label: r'Mover $ 1.234.567', onConfirm: () {}),
      ],
    );
  }
}

class _NewEnvelope extends StatelessWidget {
  const _NewEnvelope();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const UiCard(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Column(
            children: [
              UiFieldRow(
                label: 'Nombre',
                value: 'Viaje a Bariloche con la familia',
              ),
              UiFieldRow(label: 'Grupo', value: 'Metas'),
              UiFieldRow(label: 'Foto', value: 'Elegir'),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            UiChip(label: 'Sin objetivo'),
            UiChip(label: 'Mensual'),
            UiChip(label: 'Con fecha', selected: true),
          ],
        ),
        const SizedBox(height: 16),
        const Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: UiAmountCapsule(symbol: r'$', value: '50.000'),
          ),
        ),
        const SizedBox(height: 16),
        const UiCard(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: UiFieldRow(label: 'Fecha límite', value: 'Obligatoria'),
        ),
        const SizedBox(height: 28),
        UiSaveBar(label: 'Crear sobre', onConfirm: () {}),
      ],
    );
  }
}
