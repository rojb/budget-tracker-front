import 'package:ui/ui.dart';

import '../common/dates.dart';
import '../common/months.dart';
import 'envelopes_repository.dart';

/// The `TxRow` of a move of money in 22 Detalle de sobre (FR-24, FR-25):
/// - title: "Movido a (sobre)" on the source, "Movido desde (sobre)" on the
///   destination;
/// - amount: `−$ X` on the source, `+$ X` in the lavender capsule on the
///   destination;
/// - subtitle: the time it was registered, preceded by its day and month when
///   the month it was made for is not the month it was registered in;
/// - icon: left-right arrows, the one of "Mover dinero".
///
/// A move is not a transaction and has no screen, so the row has no `onTap`:
/// it shows no pressed state and no dead tap.
UiTxRow envelopeMoveRow(EnvelopeMoveData move, {required Currency currency}) {
  final money = formatMoney(move.amountMinor, currency);
  final registered = move.createdAt.toLocal();
  final registeredMonth =
      '${registered.year}-${registered.month.toString().padLeft(2, '0')}';
  final time = timeLabel(registered);
  return UiTxRow(
    icon: UiIcons.arrowLeftRight,
    title: move.outgoing
        ? 'Movido a ${move.counterpartName}'
        : 'Movido desde ${move.counterpartName}',
    subtitle: registeredMonth == move.month
        ? time
        : '${dayMonthShort(registered)}, $time',
    amount: move.outgoing ? '−$money' : '+$money',
    variant: move.outgoing ? UiTxRowVariant.expense : UiTxRowVariant.income,
  );
}
