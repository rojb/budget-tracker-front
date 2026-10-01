import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../accounts/account_picker.dart';
import '../accounts/accounts_controller.dart';
import '../common/date_sheets.dart';
import '../envelopes/envelopes_controller.dart';
import '../payees/payees_repository.dart';
import 'envelope_picker.dart';
import 'payee_picker.dart';
import 'transaction_draft.dart';
import 'transaction_filter.dart';
import 'transactions_controller.dart';

/// Screen 11 Filtrar movimientos: bottom sheet opened by the filters button of
/// 10 (FR-22). "Fechas" and "Franja horaria" (chips plus Desde / Hasta times),
/// "Tipo" (Todos, Gastos, Ingresos) and the Beneficiario, Sobre and Cuenta rows
/// that open 26, 36 and 37. The primary button reads "Ver N movimientos" with
/// the count the current choices select, and "Limpiar" resets them. Closing the
/// sheet by any means applies what is chosen, so this always returns the filter
/// to use (the unchanged one when nothing was touched).
Future<TransactionFilter> showFilterSheet(
  BuildContext context, {
  required TransactionFilter initial,
  required TransactionsController transactions,
  required EnvelopesController envelopes,
  required AccountsController accounts,
  required PayeesRepository payees,
  required String planId,
  required Currency currency,
}) async {
  final holder = ValueNotifier<TransactionFilter>(initial);
  await showUiSheet<void>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Filtrar',
      child: _FilterBody(
        holder: holder,
        transactions: transactions,
        envelopes: envelopes,
        accounts: accounts,
        payees: payees,
        planId: planId,
        currency: currency,
      ),
    ),
  );
  final result = holder.value;
  holder.dispose();
  return result;
}

class _FilterBody extends StatefulWidget {
  const _FilterBody({
    required this.holder,
    required this.transactions,
    required this.envelopes,
    required this.accounts,
    required this.payees,
    required this.planId,
    required this.currency,
  });

  final ValueNotifier<TransactionFilter> holder;
  final TransactionsController transactions;
  final EnvelopesController envelopes;
  final AccountsController accounts;
  final PayeesRepository payees;
  final String planId;
  final Currency currency;

  @override
  State<_FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<_FilterBody> {
  Timer? _debounce;
  int? _count;
  bool _countFailed = false;

  TransactionFilter get _filter => widget.holder.value;

  @override
  void initState() {
    super.initState();
    _recount(immediately: true);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _set(TransactionFilter filter) {
    widget.holder.value = filter;
    setState(() => _count = null);
    _recount();
  }

  // The count follows the choices: requested once the user stops tapping.
  void _recount({bool immediately = false}) {
    _debounce?.cancel();
    final filter = _filter;
    Future<void> run() async {
      try {
        final count = await widget.transactions.count(filter);
        if (mounted && filter == _filter) {
          setState(() {
            _count = count;
            _countFailed = false;
          });
        }
      } on Object {
        if (mounted && filter == _filter) setState(() => _countFailed = true);
      }
    }

    if (immediately) {
      run();
    } else {
      _debounce = Timer(const Duration(milliseconds: 250), run);
    }
  }

  Future<void> _pickDate({required bool from}) async {
    final filter = _filter;
    final value = await showDateSheet(
      context,
      title: from ? 'Desde' : 'Hasta',
      initial: from ? filter.from : filter.to,
    );
    if (value == null) return;
    // The range stays ordered: moving one end past the other drags it along.
    var start = from ? value : filter.from;
    var end = from ? filter.to : value;
    if (start != null && end != null && start.isAfter(end)) {
      if (from) {
        end = start;
      } else {
        start = end;
      }
    }
    _set(filter.withDates(start, end));
  }

  Future<void> _pickTime({required bool from}) async {
    final filter = _filter;
    final value = await showTimeSheet(
      context,
      title: from ? 'Desde' : 'Hasta',
      initial: from ? filter.timeFrom : filter.timeTo,
    );
    if (value == null) return;
    _set(
      from
          ? filter.withTimes(value, filter.timeTo)
          : filter.withTimes(filter.timeFrom, value),
    );
  }

  Future<void> _pickPayee() async {
    final filter = _filter;
    final result = await showPayeePicker(
      context,
      repository: widget.payees,
      planId: widget.planId,
      envelopes: widget.envelopes,
      selected: filter.payeeId == null
          ? null
          : PayeePick(id: filter.payeeId, name: filter.payeeName ?? ''),
      allowCreate: false,
    );
    switch (result) {
      case PayeeChosen(:final pick):
        _set(filter.withPayee(pick.id, pick.name));
      case PayeeCleared():
        _set(filter.withPayee(null, null));
      case null:
        break;
    }
  }

  Future<void> _pickEnvelope() async {
    final filter = _filter;
    final result = await showEnvelopePicker(
      context,
      envelopes: widget.envelopes,
      currency: widget.currency,
      selectedId: filter.envelopeId,
    );
    if (result case EnvelopeChosen(:final envelopeId)) {
      // Choosing the selected envelope again clears the choice.
      _set(
        envelopeId == filter.envelopeId
            ? filter.withEnvelope(null, null)
            : filter.withEnvelope(
                envelopeId,
                widget.envelopes.lineById(envelopeId)?.envelope.name,
              ),
      );
    }
  }

  Future<void> _pickAccount() async {
    final filter = _filter;
    final picked = await showAccountPicker(
      context,
      accounts: widget.accounts,
      currency: widget.currency,
      selectedId: filter.accountId,
    );
    if (picked == null) return;
    _set(
      picked.id == filter.accountId
          ? filter.withAccount(null, null)
          : filter.withAccount(picked.id, picked.name),
    );
  }

  String get _applyLabel {
    final count = _count;
    if (count == null) return _countFailed ? 'Ver movimientos' : 'Ver…';
    return count == 1 ? 'Ver 1 movimiento' : 'Ver $count movimientos';
  }

  Widget _heading(String text, {double top = 18}) => Padding(
    padding: EdgeInsets.only(top: top, bottom: 10, left: 4),
    child: Text(text, style: UiTypography.custom(20)),
  );

  @override
  Widget build(BuildContext context) {
    final filter = _filter;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _heading('Fechas', top: 0),
          Row(
            children: [
              Expanded(
                child: UiPickerField(
                  label: 'Desde',
                  icon: UiIcons.calendar,
                  value: filter.from == null ? null : formatDate(filter.from!),
                  onTap: () => _pickDate(from: true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: UiPickerField(
                  label: 'Hasta',
                  icon: UiIcons.calendar,
                  value: filter.to == null ? null : formatDate(filter.to!),
                  onTap: () => _pickDate(from: false),
                ),
              ),
            ],
          ),
          _heading('Franja horaria'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final band in TimeBand.values)
                UiChip(
                  label: band.label,
                  selected: filter.band == band,
                  onPressed: () => _set(filter.withTimes(band.from, band.to)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: UiPickerField(
                  label: 'Desde',
                  icon: UiIcons.clock,
                  value: filter.timeFrom == null
                      ? null
                      : formatTime(filter.timeFrom!),
                  onTap: () => _pickTime(from: true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: UiPickerField(
                  label: 'Hasta',
                  icon: UiIcons.clock,
                  value: filter.timeTo == null
                      ? null
                      : formatTime(filter.timeTo!),
                  onTap: () => _pickTime(from: false),
                ),
              ),
            ],
          ),
          _heading('Tipo'),
          UiToggle(
            labels: const ['Todos', 'Gastos', 'Ingresos'],
            selectedIndex: filter.kind.index,
            onChanged: (index) =>
                _set(filter.withKind(TransactionKind.values[index])),
          ),
          const SizedBox(height: 12),
          UiFilterRow(
            icon: UiIcons.store,
            label: 'Beneficiario',
            value: filter.payeeName ?? 'Todos',
            active: filter.payeeId != null,
            onTap: _pickPayee,
          ),
          const SizedBox(height: 8),
          UiFilterRow(
            icon: UiIcons.wallet,
            label: 'Sobre',
            value: filter.envelopeName ?? 'Todos',
            active: filter.envelopeId != null,
            onTap: _pickEnvelope,
          ),
          const SizedBox(height: 8),
          UiFilterRow(
            icon: UiIcons.creditCard,
            label: 'Cuenta',
            value: filter.accountName ?? 'Todas',
            active: filter.accountId != null,
            onTap: _pickAccount,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: UiButton(
                  label: 'Limpiar',
                  variant: UiButtonVariant.white,
                  onPressed: () => _set(filter.clearedFilters()),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: UiButton(
                  label: _applyLabel,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
