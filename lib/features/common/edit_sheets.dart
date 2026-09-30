import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Text value editor for a `UiFieldRow` (names in 20, 28, 42). Returns the
/// trimmed text, or null when dismissed.
Future<String?> showTextEditSheet(
  BuildContext context, {
  required String title,
  required String label,
  String initial = '',
  int maxLength = 60,
}) {
  final controller = TextEditingController(text: initial);
  return showUiSheet<String>(
    context,
    builder: (sheetContext) => UiSheet(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiTextField(
            label: label,
            controller: controller,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) =>
                Navigator.of(sheetContext).pop(controller.text.trim()),
          ),
          const SizedBox(height: 16),
          UiButton(
            label: 'Listo',
            onPressed: () =>
                Navigator.of(sheetContext).pop(controller.text.trim()),
          ),
        ],
      ),
    ),
  ).whenComplete(controller.dispose);
}

/// Amount editor: the `AmountCapsule` with the plan currency and a keypad of
/// `Key`s that fills minor units from the right, so USD/EUR get their two
/// decimals without a decimal key. Returns minor units, or null when dismissed.
Future<int?> showAmountSheet(
  BuildContext context, {
  required String title,
  required Currency currency,
  int initialMinor = 0,
}) {
  return showUiSheet<int>(
    context,
    builder: (sheetContext) => UiSheet(
      title: title,
      child: _AmountPad(currency: currency, initialMinor: initialMinor),
    ),
  );
}

/// Digits of [minor] formatted without the symbol ("300.000", "500,00").
String formatAmountValue(int minor, Currency currency) {
  final formatted = formatMoney(minor, currency);
  return formatted.substring(formatted.indexOf(' ') + 1);
}

class _AmountPad extends StatefulWidget {
  const _AmountPad({required this.currency, required this.initialMinor});

  final Currency currency;
  final int initialMinor;

  @override
  State<_AmountPad> createState() => _AmountPadState();
}

class _AmountPadState extends State<_AmountPad> {
  late int _minor = widget.initialMinor.abs();

  static const int _max = 999999999999; // 12 digits keeps it a safe integer.

  void _digits(String digits) {
    var next = _minor;
    for (final d in digits.split('')) {
      next = next * 10 + int.parse(d);
    }
    if (next <= _max) setState(() => _minor = next);
  }

  void _delete() => setState(() => _minor = _minor ~/ 10);

  @override
  Widget build(BuildContext context) {
    Widget key(String label) => Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: UiKey(
          label: label,
          width: double.infinity,
          onPressed: () => _digits(label),
        ),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: UiAmountCapsule(
              symbol: widget.currency.symbol,
              value: formatAmountValue(_minor, widget.currency),
            ),
          ),
        ),
        const SizedBox(height: 18),
        for (final row in const [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
        ])
          Row(children: [for (final d in row) key(d)]),
        Row(
          children: [
            key('00'),
            key('0'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: UiKey(
                  variant: UiKeyVariant.del,
                  width: double.infinity,
                  onPressed: _delete,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        UiButton(
          label: 'Listo',
          onPressed: () => Navigator.of(context).pop(_minor),
        ),
      ],
    );
  }
}
