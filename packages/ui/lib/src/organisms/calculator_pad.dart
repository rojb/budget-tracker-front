import 'package:flutter/widgets.dart';

import '../atoms/key.dart';

/// Calculator keypad of 07 Nuevo movimiento (PRD-ux-spec.md section 8, `Key`):
/// four rows of four keys, the digits and the decimal comma in `surface` and
/// the operators `÷ × − +` in lavender, with the backspace key next to the
/// zero. It reports keys only: [onKey] gets the key's label (`"7"`, `","`,
/// `"÷"`) and [onDelete] the backspace, so the expression lives in the screen.
class UiCalculatorPad extends StatelessWidget {
  const UiCalculatorPad({
    required this.onKey,
    required this.onDelete,
    this.decimalEnabled = true,
    super.key,
  });

  final ValueChanged<String> onKey;
  final VoidCallback onDelete;

  /// Mutes the decimal comma when the screen cannot take another one.
  final bool decimalEnabled;

  static const List<List<String>> _rows = [
    ['7', '8', '9', '÷'],
    ['4', '5', '6', '×'],
    ['1', '2', '3', '−'],
    [',', '0', '', '+'],
  ];

  static const Set<String> _operators = {'÷', '×', '−', '+'};

  @override
  Widget build(BuildContext context) {
    Widget cell(String label) {
      final isOperator = _operators.contains(label);
      final Widget key;
      if (label.isEmpty) {
        key = UiKey(
          variant: UiKeyVariant.del,
          width: double.infinity,
          onPressed: onDelete,
        );
      } else {
        key = UiKey(
          label: label,
          variant: isOperator ? UiKeyVariant.operator : UiKeyVariant.number,
          width: double.infinity,
          onPressed: label == ',' && !decimalEnabled
              ? null
              : () => onKey(label),
        );
      }
      return Expanded(
        child: Padding(padding: const EdgeInsets.all(3), child: key),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in _rows)
          Row(children: [for (final key in row) cell(key)]),
      ],
    );
  }
}
