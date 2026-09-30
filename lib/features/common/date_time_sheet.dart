import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'dates.dart';
import 'months.dart';

/// Screen 38 Fecha y hora: calendar plus hour/minute steppers and "Listo".
/// Returns the chosen local instant, or null when closed (the value is kept).
/// Shared by 29 and, later, 07/09/11/12 (add-transactions).
Future<DateTime?> showDateTimeSheet(BuildContext context, DateTime initial) {
  return showUiSheet<DateTime>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Fecha y hora',
      child: _DateTimePicker(initial: initial),
    ),
  );
}

class _DateTimePicker extends StatefulWidget {
  const _DateTimePicker({required this.initial});

  final DateTime initial;

  @override
  State<_DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<_DateTimePicker> {
  late DateTime _value = widget.initial.toLocal();
  late DateTime _month = DateTime(_value.year, _value.month);

  void _set(DateTime value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(UiIcons.clock, size: 18, color: UiColors.inkMuted),
            const SizedBox(width: 8),
            Text(
              dateTimeLabel(_value, now: now),
              style: UiTypography.custom(15, color: UiColors.inkMuted),
            ),
          ],
        ),
        const SizedBox(height: 12),
        UiCalendarMonth(
          month: _month,
          monthLabel: monthLabel(_month),
          selected: _value,
          today: now,
          onPrevious: () =>
              setState(() => _month = DateTime(_month.year, _month.month - 1)),
          onNext: () =>
              setState(() => _month = DateTime(_month.year, _month.month + 1)),
          onDaySelected: (day) => _set(
            DateTime(day.year, day.month, day.day, _value.hour, _value.minute),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiStepper(
              value: _value.hour.toString().padLeft(2, '0'),
              label: 'Hora',
              onIncrement: () => _set(_withTime((_value.hour + 1) % 24, null)),
              onDecrement: () => _set(_withTime((_value.hour + 23) % 24, null)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(':'),
            ),
            UiStepper(
              value: _value.minute.toString().padLeft(2, '0'),
              label: 'Minutos',
              onIncrement: () =>
                  _set(_withTime(null, (_value.minute + 1) % 60)),
              onDecrement: () =>
                  _set(_withTime(null, (_value.minute + 59) % 60)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        UiButton(
          label: 'Listo',
          icon: UiIcons.check,
          onPressed: () => Navigator.of(context).pop(_value),
        ),
      ],
    );
  }

  DateTime _withTime(int? hour, int? minute) => DateTime(
    _value.year,
    _value.month,
    _value.day,
    hour ?? _value.hour,
    minute ?? _value.minute,
  );
}
