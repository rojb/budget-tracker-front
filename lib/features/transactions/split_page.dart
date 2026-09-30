import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../accounts/accounts_controller.dart';
import '../common/dates.dart';
import '../common/edit_sheets.dart';
import '../envelopes/envelopes_controller.dart';
import '../plans/plans_controller.dart';
import 'envelope_picker.dart';
import 'new_transaction_page.dart';
import 'transaction_draft.dart';
import 'transactions_controller.dart';

/// Screen 08 Dividir pago: the expense of 07 shared between two or more
/// envelopes (FR-14). The `SaveBar` stays Disabled ("Faltan $ X" / "Sobran
/// $ X") until the portions add up exactly to the total; saving records the
/// whole expense and returns to the screen that opened 07.
class SplitPage extends StatefulWidget {
  const SplitPage({
    required this.draft,
    required this.plans,
    required this.accounts,
    required this.envelopes,
    required this.transactions,
    super.key,
  });

  final TransactionDraft draft;
  final PlansController plans;
  final AccountsController accounts;
  final EnvelopesController envelopes;
  final TransactionsController transactions;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  static const int _maxParts = 20;

  String? _error;
  bool _saving = false;

  TransactionDraft get _draft => widget.draft;
  Currency get _currency => widget.plans.currency;

  String _money(int minor) => formatMoney(minor, _currency);

  Future<void> _pickFor(int index) async {
    final part = _draft.splits[index];
    final result = await showEnvelopePicker(
      context,
      envelopes: widget.envelopes,
      currency: _currency,
      selectedId: part.envelopeId,
      exclude: {
        for (final other in _draft.splits)
          if (other != part && other.envelopeId != null) other.envelopeId!,
      },
    );
    if (result case EnvelopeChosen(:final envelopeId)) {
      _draft.setSplitEnvelope(index, envelopeId);
    }
  }

  Future<void> _addPart() async {
    final result = await showEnvelopePicker(
      context,
      envelopes: widget.envelopes,
      currency: _currency,
      exclude: {
        for (final part in _draft.splits)
          if (part.envelopeId != null) part.envelopeId!,
      },
    );
    if (result case EnvelopeChosen(:final envelopeId)) {
      _draft.addSplit(envelopeId);
    }
  }

  Future<void> _editAmount(int index) async {
    final value = await showAmountSheet(
      context,
      title: 'Monto de la parte',
      currency: _currency,
      initialMinor: _draft.splits[index].amountMinor,
    );
    if (value != null) _draft.setSplitAmount(index, value);
  }

  Future<void> _save() async {
    if (_saving || !_draft.splitValid) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final saved = await saveTransaction(
      context,
      draft: _draft,
      transaction: _draft.buildSplit(),
      transactions: widget.transactions,
      envelopes: widget.envelopes,
      accounts: widget.accounts,
      onError: (message) {
        if (mounted) setState(() => _error = message);
      },
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved) context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([_draft, widget.envelopes]),
          builder: (context, _) => _content(context),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final draft = _draft;
    final total = draft.amountMinor ?? 0;
    final distributed = draft.splitDistributed;
    final remaining = draft.splitRemaining;
    final progress = total <= 0 ? 0.0 : (distributed / total).clamp(0.0, 1.0);
    final String? mismatch = remaining > 0
        ? 'Las partes deben sumar el total: faltan ${_money(remaining)}.'
        : (remaining < 0
              ? 'Las partes deben sumar el total: sobran ${_money(-remaining)}.'
              : null);
    final String? incomplete = mismatch == null && !draft.splitValid
        ? 'Repartí el pago en al menos dos sobres.'
        : null;
    final String saveLabel = remaining > 0
        ? 'Faltan ${_money(remaining)}'
        : (remaining < 0
              ? 'Sobran ${_money(-remaining)}'
              : (draft.splitValid ? 'Guardar gasto' : 'Elegí los sobres'));
    final payee = draft.payee?.name ?? 'Sin beneficiario';
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            UiIconButton(
              icon: UiIcons.chevronLeft,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Volver',
              onPressed: () => context.pop(false),
            ),
            const Spacer(),
            UiIconButton(
              icon: UiIcons.close,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Cerrar',
              onPressed: () => context.pop(false),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text('Dividir pago', style: UiTypography.custom(36)),
        const SizedBox(height: 4),
        Text(
          '$payee · ${dateTimeLabel(draft.occurredAt)} · ${_money(total)}',
          style: UiTypography.custom(15, color: UiColors.inkMuted),
        ),
        const SizedBox(height: 16),
        UiSplitProgress(
          value: progress,
          distributed: 'Repartido ${_money(distributed)}',
          remaining: remaining >= 0
              ? 'Restan ${_money(remaining)}'
              : 'Sobran ${_money(-remaining)}',
        ),
        const SizedBox(height: 18),
        for (var i = 0; i < draft.splits.length; i++) ...[
          _partRow(i),
          const SizedBox(height: 8),
        ],
        if (draft.splits.length < _maxParts)
          UiSplitRow(
            variant: UiSplitRowVariant.pending,
            name: 'Elegí un sobre',
            amount: _money(math.max(0, remaining)),
            attention: remaining > 0,
            onTap: _addPart,
          ),
        if (mismatch != null || incomplete != null || _error != null) ...[
          const SizedBox(height: 12),
          UiFormMessage(message: _error ?? mismatch ?? incomplete!),
        ],
        const SizedBox(height: 20),
        Center(
          child: UiSaveBar(
            label: saveLabel,
            enabled: draft.splitValid && !_saving,
            leadingIcon: UiIcons.split,
            onConfirm: _save,
          ),
        ),
      ],
    );
  }

  Widget _partRow(int index) {
    final part = _draft.splits[index];
    final line = part.envelopeId == null
        ? null
        : widget.envelopes.lineById(part.envelopeId!);
    return UiSplitRow(
      icon: line == null ? UiIcons.tag : uiEnvelopeIcon(line.envelope.icon),
      name: line?.envelope.name ?? 'Elegí un sobre',
      subtitle: line == null
          ? null
          : '${_money(line.availableMinor)} disponible',
      amount: _money(part.amountMinor),
      onTap: () => _pickFor(index),
      onAmountTap: () => _editAmount(index),
      onLongPress: _draft.splits.length > 1
          ? () => _draft.removeSplit(index)
          : null,
    );
  }
}
