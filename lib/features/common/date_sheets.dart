import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'months.dart';

/// Calendar-only variant of 38 Fecha y hora, for the "Desde" / "Hasta" fields
/// of 11 Filtrar movimientos: the month calendar and "Listo". Returns the
/// chosen day (local midnight), or null when closed.
Future<DateTime?> showDateSheet(
  BuildContext context, {
  required String title,
  DateTime? initial,
}) {
  return showUiSheet<DateTime>(
    context,
    builder: (sheetContext) =>
        UiSheet(title: title, child: _DatePicker(initial: initial)),
  );
}

class _DatePicker extends StatefulWidget {
  const _DatePicker({required this.initial});

  final DateTime? initial;

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  late DateTime? _value = widget.initial;
  late DateTime _month = DateTime(
    (widget.initial ?? DateTime.now()).year,
    (widget.initial ?? DateTime.now()).month,
  );

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UiCalendarMonth(
          month: _month,
          monthLabel: monthLabel(_month),
          selected: _value,
          today: now,
          onPrevious: () =>
              setState(() => _month = DateTime(_month.year, _month.month - 1)),
          onNext: () =>
              setState(() => _month = DateTime(_month.year, _month.month + 1)),
          onDaySelected: (day) =>
              setState(() => _value = DateTime(day.year, day.month, day.day)),
        ),
        const SizedBox(height: 16),
        UiButton(
          label: 'Listo',
          icon: UiIcons.check,
          onPressed: _value == null
              ? null
              : () => Navigator.of(context).pop(_value),
        ),
      ],
    );
  }
}

/// Time-only variant of 38 for the "Desde" / "Hasta" time fields of 11: the
/// hour and minute steppers and "Listo". Returns the chosen time, or null when
/// closed.
Future<TimeOfDay?> showTimeSheet(
  BuildContext context, {
  required String title,
  TimeOfDay? initial,
}) {
  return showUiSheet<TimeOfDay>(
    context,
    builder: (sheetContext) => UiSheet(
      title: title,
      child: _TimePicker(initial: initial ?? const TimeOfDay(hour: 12, minute: 0)),
    ),
  );
}

class _TimePicker extends StatefulWidget {
  const _TimePicker({required this.initial});

  final TimeOfDay initial;

  @override
  State<_TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<_TimePicker> {
  late int _hour = widget.initial.hour;
  late int _minute = widget.initial.minute;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiStepper(
              value: _hour.toString().padLeft(2, '0'),
              label: 'Hora',
              onIncrement: () => setState(() => _hour = (_hour + 1) % 24),
              onDecrement: () => setState(() => _hour = (_hour + 23) % 24),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(':'),
            ),
            UiStepper(
              value: _minute.toString().padLeft(2, '0'),
              label: 'Minutos',
              onIncrement: () => setState(() => _minute = (_minute + 1) % 60),
              onDecrement: () => setState(() => _minute = (_minute + 59) % 60),
            ),
          ],
        ),
        const SizedBox(height: 16),
        UiButton(
          label: 'Listo',
          icon: UiIcons.check,
          onPressed: () =>
              Navigator.of(context).pop(TimeOfDay(hour: _hour, minute: _minute)),
        ),
      ],
    );
  }
}
