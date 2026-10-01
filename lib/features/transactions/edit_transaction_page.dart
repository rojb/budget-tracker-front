import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../accounts/account_picker.dart';
import '../accounts/accounts_controller.dart';
import '../common/date_time_sheet.dart';
import '../common/dates.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../common/months.dart';
import '../envelopes/envelopes_controller.dart';
import '../payees/payees_repository.dart';
import '../plans/plans_controller.dart';
import 'amount_expression.dart';
import 'delete_transaction_sheet.dart';
import 'envelope_picker.dart';
import 'payee_picker.dart';
import 'transaction_change.dart';
import 'transaction_draft.dart';
import 'transactions_controller.dart';
import 'transactions_repository.dart';

/// Screen 12 Editar movimiento: the form of 07 loaded with an existing
/// movement. Any field can change, including the date (to another month) and,
/// for a split, its portions in 08. A lavender note warns when the movement
/// belongs to a month that is already over, "Antes $ X" shows the saved amount,
/// and the trash opens 27. Saving sends the edit and returns a
/// [TransactionEdited] (or [TransactionDeleted]) to 10 / 14, which show the toast
/// of 49 with "Deshacer".
class EditTransactionPage extends StatefulWidget {
  const EditTransactionPage({
    required this.transaction,
    required this.plans,
    required this.accounts,
    required this.envelopes,
    required this.transactions,
    required this.payees,
    super.key,
  });

  final TransactionData transaction;
  final PlansController plans;
  final AccountsController accounts;
  final EnvelopesController envelopes;
  final TransactionsController transactions;
  final PayeesRepository payees;

  @override
  State<EditTransactionPage> createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  late final TransactionDraft _draft = TransactionDraft.fromTransaction(
    widget.transaction,
    currency: widget.plans.currency,
  );
  String? _error;
  bool _saving = false;
  bool _pad = false;

  Currency get _currency => widget.plans.currency;
  TransactionData get _original => widget.transaction;

  @override
  void initState() {
    super.initState();
    _draft.addListener(_clearError);
  }

  @override
  void dispose() {
    _draft.removeListener(_clearError);
    _draft.dispose();
    super.dispose();
  }

  void _clearError() {
    if (_error != null && mounted) setState(() => _error = null);
  }

  void _onKey(String key) {
    if (key == ',') {
      _draft.typeDecimal();
    } else if (AmountExpression.operators.contains(key)) {
      _draft.typeOperator(key);
    } else {
      _draft.typeDigits(key);
    }
  }

  Future<void> _pickPayee() async {
    final plan = widget.plans.activePlan;
    if (plan == null) return;
    final result = await showPayeePicker(
      context,
      repository: widget.payees,
      planId: plan.id,
      envelopes: widget.envelopes,
      selected: _draft.payee,
    );
    switch (result) {
      case PayeeChosen(:final pick):
        // The suggested envelope never overrides the one of a saved movement.
        _draft.pickPayee(pick, suggestionExists: false);
      case PayeeCleared():
        _draft.pickPayee(null);
      case null:
        break;
    }
  }

  Future<void> _pickEnvelope() async {
    final expense = _draft.isExpense;
    final result = await showEnvelopePicker(
      context,
      envelopes: widget.envelopes,
      currency: _currency,
      selectedId: expense ? _draft.envelopeId : _draft.incomeEnvelopeId,
      readyToAssignSelected: !expense && !_draft.incomeToEnvelope,
      offerReadyToAssign: !expense,
    );
    switch (result) {
      case EnvelopeChosen(:final envelopeId):
        _draft.pickEnvelope(envelopeId);
      case ReadyToAssignChosen():
        _draft.chooseReadyToAssign();
      case null:
        break;
    }
  }

  // A split is edited in 08; its SaveBar returns here and the edit is sent.
  Future<void> _openSplit() async {
    final confirmed = await context.push<bool>(
      AppRoutes.splitTransaction,
      extra: _draft,
    );
    if (confirmed == true && mounted) _save();
  }

  Future<void> _pickAccount() async {
    final picked = await showAccountPicker(
      context,
      accounts: widget.accounts,
      currency: _currency,
      selectedId: _draft.accountId,
    );
    if (picked != null) _draft.setAccount(picked.id);
  }

  Future<void> _pickDate() async {
    final value = await showDateTimeSheet(context, _draft.occurredAt);
    if (value != null) _draft.setOccurredAt(value);
  }

  Future<void> _editDescription() async {
    final value = await showTextEditSheet(
      context,
      title: 'Descripción',
      label: 'Descripción',
      initial: _draft.description,
      maxLength: 120,
    );
    if (value != null) _draft.setDescription(value);
  }

  /// First error that stops the save, or null.
  String? _validate() {
    if (_draft.isSplitEdit) {
      if (_draft.accountId == null) return 'Elegí una cuenta.';
      if (_draft.amount.isInvalid(_draft.minorUnits)) {
        return 'Revisá la operación.';
      }
      final value = _draft.amountMinor;
      if (value == null || value <= 0) return 'Ingresá un monto mayor a cero.';
      if (!_draft.splitValid) {
        return 'Las partes deben sumar el total: tocá Sobre para repartir.';
      }
      return null;
    }
    return _draft.validate();
  }

  Future<void> _save() async {
    if (_saving) return;
    final error = _validate();
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    setState(() => _saving = true);
    try {
      final change = await widget.transactions.update(
        _original.id,
        _draft.isSplitEdit ? _draft.buildSplit() : _draft.build(),
      );
      await Future.wait([widget.envelopes.load(), widget.accounts.load()]);
      if (!mounted) return;
      context.pop<TransactionOutcome>(
        TransactionEdited(before: _original, months: change.affectedMonths),
      );
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      setState(() => _saving = false);
      _showFailure(failure);
    }
  }

  void _showFailure(ApiFailure failure) {
    switch (failure.kind) {
      case ApiFailureKind.forbidden:
        showForbidden(context);
      case ApiFailureKind.conflict:
        setState(() => _error = 'La cuenta está archivada.');
      case ApiFailureKind.notFound:
        setState(
          () => _error =
              'El movimiento, un sobre, una cuenta o un beneficiario ya no existe.',
        );
        widget.envelopes.load();
        widget.accounts.load();
        widget.transactions.refresh();
      case ApiFailureKind.validation:
        setState(() => _error = failure.formErrors.firstOrNull ?? 'Revisá los datos.');
      default:
        showConnectionProblem(context);
    }
  }

  Future<void> _delete() async {
    if (_saving) return;
    final confirmed = await showDeleteTransactionSheet(
      context,
      transaction: _original,
      currency: _currency,
      envelopes: widget.envelopes,
    );
    if (confirmed != true || !mounted) return;
    setState(() => _saving = true);
    try {
      final months = await widget.transactions.remove(_original.id);
      await Future.wait([widget.envelopes.load(), widget.accounts.load()]);
      if (!mounted) return;
      context.pop<TransactionOutcome>(
        TransactionDeleted(before: _original, months: months),
      );
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      setState(() => _saving = false);
      _showFailure(failure);
    }
  }

  String _envelopeName(String? id) =>
      (id == null ? null : widget.envelopes.lineById(id)?.envelope.name) ??
      'Sin sobre';

  String _destination() {
    final draft = _draft;
    if (draft.isSplitEdit) return '${draft.splits.length} sobres';
    if (draft.isExpense) {
      return draft.envelopeId == null
          ? 'Elegir'
          : _envelopeName(draft.envelopeId);
    }
    return draft.incomeToEnvelope
        ? _envelopeName(draft.incomeEnvelopeId)
        : 'Listo para asignar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([
            _draft,
            widget.accounts,
            widget.envelopes,
          ]),
          builder: (context, _) => _form(context),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    final draft = _draft;
    final account = draft.accountId == null
        ? null
        : widget.accounts.byId(draft.accountId!);
    final caption = draft.amount.caption;
    final amount = draft.amountMinor;
    final changedAmount = amount != null && amount != _original.amountMinor;
    final closed = isClosedMonth(_original.occurredAt);
    final months = monthsFrom(_original.occurredAt);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        Row(
          children: [
            UiIconButton(
              icon: UiIcons.chevronLeft,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Volver',
              onPressed: () => context.pop(),
            ),
            const Spacer(),
            UiIconButton(
              icon: UiIcons.trash,
              variant: UiIconButtonVariant.danger,
              semanticLabel: 'Eliminar movimiento',
              onPressed: _delete,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text('Editar movimiento', style: UiTypography.custom(36)),
        const SizedBox(height: 14),
        if (closed) ...[
          UiInfoNote(
            variant: UiInfoNoteVariant.lavender,
            icon: UiIcons.history,
            title:
                'Es de ${monthName(_original.occurredAt.toLocal())}, un mes cerrado',
            text:
                'Al guardar se recalculan ${monthsText(months)} y tu Listo para asignar.',
          ),
          const SizedBox(height: 16),
        ],
        Center(
          child: Semantics(
            button: true,
            label: 'Monto, mostrar teclado',
            child: GestureDetector(
              onTap: () => setState(() => _pad = true),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: UiAmountCapsule(
                  symbol: _currency.symbol,
                  value: draft.amount.display(_currency.minorUnits),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 34,
          child: Center(
            child: changedAmount || caption != null
                ? Text(
                    caption ??
                        'Antes ${formatMoney(_original.amountMinor, _currency)}',
                    style: UiTypography.caption,
                  )
                : null,
          ),
        ),
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Column(
            children: [
              UiFieldRow(
                label: 'Beneficiario',
                value: draft.payee?.name ?? 'Sin beneficiario',
                onTap: _pickPayee,
              ),
              UiFieldRow(
                label: 'Sobre',
                value: _destination(),
                onTap: draft.isSplitEdit ? _openSplit : _pickEnvelope,
              ),
              UiFieldRow(
                label: 'Cuenta',
                value: account?.name ?? 'Elegir',
                onTap: _pickAccount,
              ),
              UiFieldRow(
                label: 'Fecha y hora',
                value: dateTimeLabel(draft.occurredAt),
                onTap: _pickDate,
              ),
              UiFieldRow(
                label: 'Descripción',
                value: draft.description.isEmpty
                    ? 'Agregar'
                    : draft.description,
                onTap: _editDescription,
              ),
            ],
          ),
        ),
        if (_pad) ...[
          const SizedBox(height: 12),
          UiCalculatorPad(onKey: _onKey, onDelete: draft.typeDelete),
        ],
        if (_error != null) ...[
          const SizedBox(height: 8),
          UiFormMessage(message: _error!),
        ],
        const SizedBox(height: 14),
        Center(
          child: UiSaveBar(
            label: 'Guardar cambios',
            enabled: !_saving,
            leadingIcon: UiIcons.calculator,
            onConfirm: _save,
            onCalculatorPressed: () => setState(() => _pad = !_pad),
          ),
        ),
      ],
    );
  }
}
