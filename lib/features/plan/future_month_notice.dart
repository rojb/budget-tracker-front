import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

/// The notice of 04 Plan · mes futuro, with "Hoy" back to the current month.
class FutureMonthNotice extends StatelessWidget {
  const FutureMonthNotice({required this.onToday, super.key});

  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    return UiInfoNote(
      variant: UiInfoNoteVariant.lavender,
      icon: UiIcons.calendarClock,
      title: 'Estás en un mes futuro',
      text: 'Lo que asignes acá se reserva hoy.',
      actionLabel: 'Hoy',
      onAction: onToday,
    );
  }
}
