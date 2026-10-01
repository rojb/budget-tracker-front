import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../format/money.dart';
import '../tokens/colors.dart';
import '../tokens/icons.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';

/// Four-option currency card of 20 Nuevo plan (FR-40): Pesos $, Dólares US$,
/// Euros €, Bolivianos Bs. One row per currency, as in the render. The chosen
/// option is a lavender pill with a white symbol badge and a check; the others
/// show the symbol as plain text.
class UiCurrencySelector extends StatelessWidget {
  const UiCurrencySelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final Currency selected;
  final ValueChanged<Currency> onChanged;

  static const Map<Currency, String> _labels = {
    Currency.ars: 'Pesos (ARS)',
    Currency.usd: 'Dólares (USD)',
    Currency.eur: 'Euros (EUR)',
    Currency.bob: 'Bolivianos (BOB)',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: UiColors.surface,
        borderRadius: BorderRadius.circular(UiRadius.card),
      ),
      child: Column(
        children: [
          for (final currency in Currency.values)
            _option(currency, currency == selected),
        ],
      ),
    );
  }

  Widget _option(Currency currency, bool isSelected) {
    final symbolStyle = UiTypography.custom(
      currency.symbol.length > 1 ? 15 : 17,
    );
    return UiHitTarget(
      onTap: () => onChanged(currency),
      semanticLabel: _labels[currency],
      selected: isSelected,
      minWidth: 0,
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? UiColors.lavender : null,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? UiColors.surface : null,
                shape: BoxShape.circle,
              ),
              child: Text(currency.symbol, style: symbolStyle),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(_labels[currency]!, style: UiTypography.custom(17)),
            ),
            if (isSelected)
              const Icon(UiIcons.check, size: 20, color: UiColors.ink),
          ],
        ),
      ),
    );
  }
}
