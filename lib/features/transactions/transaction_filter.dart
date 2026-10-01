import 'package:flutter/material.dart';

import '../common/months.dart';

/// Direction filter of 11 "Tipo": all, only expenses or only incomes.
enum TransactionKind { all, expense, income }

/// Time-of-day chips of 11 "Franja horaria". [allDay] is no filter.
enum TimeBand {
  allDay('Todo el día', null, null),
  morning(
    'Mañana',
    TimeOfDay(hour: 6, minute: 0),
    TimeOfDay(hour: 11, minute: 59),
  ),
  afternoon(
    'Tarde',
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 17, minute: 59),
  ),
  night(
    'Noche',
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 23, minute: 59),
  );

  const TimeBand(this.label, this.from, this.to);

  final String label;
  final TimeOfDay? from;
  final TimeOfDay? to;
}

/// What 10 Movimientos shows: the filters of 11 (FR-22) and the text typed in
/// the search field. Immutable; every change produces a new filter.
///
/// Dates are local calendar days and times local times of day; the API reads
/// them in the plan's time zone. The names of the payee, envelope and account
/// travel with their ids because the chips of 10 show them.
class TransactionFilter {
  const TransactionFilter({
    this.from,
    this.to,
    this.timeFrom,
    this.timeTo,
    this.kind = TransactionKind.all,
    this.payeeId,
    this.payeeName,
    this.envelopeId,
    this.envelopeName,
    this.accountId,
    this.accountName,
    this.query = '',
  });

  static const TransactionFilter none = TransactionFilter();

  final DateTime? from;
  final DateTime? to;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeTo;
  final TransactionKind kind;
  final String? payeeId;
  final String? payeeName;
  final String? envelopeId;
  final String? envelopeName;
  final String? accountId;
  final String? accountName;

  /// Text of the search field of 10 (not part of 11).
  final String query;

  bool get hasDates => from != null || to != null;
  bool get hasTimes => timeFrom != null || timeTo != null;

  /// A filter of 11 is set (lights the filters button of 10).
  bool get hasFilters =>
      hasDates ||
      hasTimes ||
      kind != TransactionKind.all ||
      payeeId != null ||
      envelopeId != null ||
      accountId != null;

  /// Filters or a search are set: 10 shows the summary card.
  bool get isActive => hasFilters || query.isNotEmpty;

  /// The chip of "Franja horaria" the times match, or null for a hand-made range.
  TimeBand? get band {
    if (!hasTimes) return TimeBand.allDay;
    for (final band in TimeBand.values) {
      if (band.from != null && band.from == timeFrom && band.to == timeTo) {
        return band;
      }
    }
    return null;
  }

  TransactionFilter withDates(DateTime? from, DateTime? to) =>
      _copy(from: () => from, to: () => to);

  TransactionFilter withTimes(TimeOfDay? from, TimeOfDay? to) =>
      _copy(timeFrom: () => from, timeTo: () => to);

  TransactionFilter withKind(TransactionKind kind) => _copy(kind: kind);

  TransactionFilter withPayee(String? id, String? name) =>
      _copy(payeeId: () => id, payeeName: () => name);

  TransactionFilter withEnvelope(String? id, String? name) =>
      _copy(envelopeId: () => id, envelopeName: () => name);

  TransactionFilter withAccount(String? id, String? name) =>
      _copy(accountId: () => id, accountName: () => name);

  TransactionFilter withQuery(String query) => _copy(query: query.trim());

  /// Every filter of 11 removed; the search text stays.
  TransactionFilter clearedFilters() => TransactionFilter(query: query);

  TransactionFilter _copy({
    DateTime? Function()? from,
    DateTime? Function()? to,
    TimeOfDay? Function()? timeFrom,
    TimeOfDay? Function()? timeTo,
    TransactionKind? kind,
    String? Function()? payeeId,
    String? Function()? payeeName,
    String? Function()? envelopeId,
    String? Function()? envelopeName,
    String? Function()? accountId,
    String? Function()? accountName,
    String? query,
  }) {
    return TransactionFilter(
      from: from != null ? from() : this.from,
      to: to != null ? to() : this.to,
      timeFrom: timeFrom != null ? timeFrom() : this.timeFrom,
      timeTo: timeTo != null ? timeTo() : this.timeTo,
      kind: kind ?? this.kind,
      payeeId: payeeId != null ? payeeId() : this.payeeId,
      payeeName: payeeName != null ? payeeName() : this.payeeName,
      envelopeId: envelopeId != null ? envelopeId() : this.envelopeId,
      envelopeName: envelopeName != null ? envelopeName() : this.envelopeName,
      accountId: accountId != null ? accountId() : this.accountId,
      accountName: accountName != null ? accountName() : this.accountName,
      query: query ?? this.query,
    );
  }

  /// "1 – 30 sep", "28 ago – 3 sep", "Desde 1 sep" or "Hasta 30 sep".
  String? get dateLabel {
    final from = this.from;
    final to = this.to;
    if (from == null && to == null) return null;
    if (from != null && to == null) return 'Desde ${dayMonthShort(from)}';
    if (from == null) return 'Hasta ${dayMonthShort(to!)}';
    if (_sameDay(from, to!)) return dayMonthShort(from);
    if (from.month == to.month && from.year == to.year) {
      return '${from.day} – ${dayMonthShort(to)}';
    }
    return '${dayMonthShort(from)} – ${dayMonthShort(to)}';
  }

  /// "18:00 – 23:59", "Desde 18:00" or "Hasta 12:00".
  String? get timeLabel {
    final from = timeFrom;
    final to = timeTo;
    if (from == null && to == null) return null;
    if (from != null && to == null) return 'Desde ${formatTime(from)}';
    if (from == null) return 'Hasta ${formatTime(to!)}';
    return '${formatTime(from)} – ${formatTime(to!)}';
  }

  @override
  bool operator ==(Object other) =>
      other is TransactionFilter &&
      other.from == from &&
      other.to == to &&
      other.timeFrom == timeFrom &&
      other.timeTo == timeTo &&
      other.kind == kind &&
      other.payeeId == payeeId &&
      other.envelopeId == envelopeId &&
      other.accountId == accountId &&
      other.query == query;

  @override
  int get hashCode => Object.hash(
    from,
    to,
    timeFrom,
    timeTo,
    kind,
    payeeId,
    envelopeId,
    accountId,
    query,
  );
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// "18:00" (the API's `HH:mm`).
String formatTime(TimeOfDay time) =>
    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

/// "01/09/2026", the field format of 11.
String formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
