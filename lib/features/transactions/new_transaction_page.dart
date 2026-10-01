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
import '../envelopes/envelopes_controller.dart';
import '../payees/payees_repository.dart';
import '../plans/plans_controller.dart';
import 'amount_expression.dart';
import 'envelope_picker.dart';
import 'payee_picker.dart';
import 'transaction_draft.dart';
import 'transactions_controller.dart';
import 'transactions_repository.dart';

/// Screens 07 Nuevo movimiento and 09 Registrar ingreso: one page, two modes
/// (the `Toggle` flips between them and keeps what was typed). The amount takes
/// an arithmetic expression (FR-18) through the calculator pad; the `SaveBar`
/// swipes to save, and in expense mode its left icon opens 08 Dividir pago.
class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({
    required this.plans,
    required this.accounts,
    required this.envelopes,
    required this.transactions,
    required this.payees,
    super.key,
  });

  final PlansController plans;
  final AccountsController accounts;
  final EnvelopesController envelopes;
  final TransactionsController transactions;
  final PayeesRepository payees;

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  late final TransactionDraft _draft = TransactionDraft(
    currency: widget.plans.currency,
    accountId: widget.accounts.active.firstOrNull?.id,
  );
  String? _error;
  bool _saving = false;

  /// Income only: the destination cards come first (render 09), so the pad stays
  /// hidden until the calculator icon of the `SaveBar` (or a tap on the capsule)
  /// shows it; expenses always show it (render 07).
  bool _incomePad = false;

  Currency get _currency => widget.plans.currency;

  @override
  void initState() {
    super.initState();
    widget.accounts.addListener(_defaultAccount);
    _draft.addListener(_clearError);
  }

  @override
  void dispose() {
    widget.accounts.removeListener(_defaultAccount);
    _draft.removeListener(_clearError);
    _draft.dispose();
    super.dispose();
  }

  // The accounts may still be loading when the page opens.
  void _defaultAccount() {
    if (_draft.accountId == null && widget.accounts.active.isNotEmpty) {
      _draft.setAccount(widget.accounts.active.first.id);
    }
  }

  void _clearError() {
    if (_error != null && mounted) setState(() => _error = null);
  }

  bool get _padVisible => _draft.isExpense || _incomePad;

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
        final suggested = pick.suggestedEnvelopeId;
        _draft.pickPayee(
          pick,
          suggestionExists:
              suggested != null && widget.envelopes.lineById(suggested) != null,
        );
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
    );
    if (result case EnvelopeChosen(:final envelopeId)) {
      _draft.pickEnvelope(envelopeId);
    }
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

  // The split icon of the SaveBar: 08 needs a positive total to divide.
  Future<void> _openSplit() async {
    if (_draft.amount.isInvalid(_draft.minorUnits)) {
      setState(() => _error = 'Revisá la operación.');
      return;
    }
    final total = _draft.amountMinor;
    if (total == null || total <= 0) {
      setState(() => _error = 'Ingresá un monto mayor a cero.');
      return;
    }
    _draft.startSplit();
    final saved = await context.push<bool>(
      AppRoutes.splitTransaction,
      extra: _draft,
    );
    if (saved == true && mounted) context.pop();
  }

  Future<void> _save() async {
    if (_saving) return;
    final error = _draft.validate();
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    setState(() => _saving = true);
    final saved = await saveTransaction(
      context,
      draft: _draft,
      transaction: _draft.build(),
      transactions: widget.transactions,
      envelopes: widget.envelopes,
      accounts: widget.accounts,
      onError: (message) {
        if (mounted) setState(() => _error = message);
      },
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved) context.pop();
  }

  String _envelopeName(String? id) =>
      (id == null ? null : widget.envelopes.lineById(id)?.envelope.name) ??
      'Elegir';

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
          builder: (context, _) {
            if (!widget.accounts.loading &&
                !widget.accounts.failed &&
                widget.accounts.active.isEmpty) {
              return _noAccount(context);
            }
            return _form(context);
          },
        ),
      ),
    );
  }

  Widget _noAccount(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: UiIconButton(
            icon: UiIcons.close,
            variant: UiIconButtonVariant.soft,
            semanticLabel: 'Cerrar',
            onPressed: () => context.pop(),
          ),
        ),
        const SizedBox(height: 18),
        Text('Nuevo movimiento', style: UiTypography.custom(36)),
        const SizedBox(height: 14),
        const UiInfoNote(
          text: 'Para registrar un movimiento necesitás al menos una cuenta.',
        ),
        const SizedBox(height: 14),
        UiButton(
          label: 'Agregar cuenta',
          icon: UiIcons.plus,
          onPressed: () => context.push(AppRoutes.newAccount),
        ),
      ],
    );
  }

  Widget _form(BuildContext context) {
    final draft = _draft;
    final expense = draft.isExpense;
    final account = draft.accountId == null
        ? null
        : widget.accounts.byId(draft.accountId!);
    final caption =
        draft.amount.caption ??
        (!expense && !_incomePad && draft.amount.isEmpty
            ? 'Tocá el monto para escribirlo'
            : null);
    final fields = <Widget>[
      UiFieldRow(
        label: 'Beneficiario',
        value: draft.payee?.name ?? 'Sin beneficiario',
        onTap: _pickPayee,
      ),
      if (expense)
        UiFieldRow(
          label: 'Sobre',
          value: _envelopeName(draft.envelopeId),
          onTap: _pickEnvelope,
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
        value: draft.description.isEmpty ? 'Agregar' : draft.description,
        onTap: _editDescription,
      ),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        Row(
          children: [
            Expanded(
              child: UiToggle(
                selectedIndex: expense ? 0 : 1,
                onChanged: (index) {
                  // Income opens with the destination cards, not the pad.
                  if (index == 1 && expense) _incomePad = false;
                  draft.setDirection(expense: index == 0);
                },
              ),
            ),
            const SizedBox(width: 12),
            UiIconButton(
              icon: UiIcons.close,
              variant: UiIconButtonVariant.soft,
              semanticLabel: 'Cerrar',
              onPressed: () => context.pop(),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Center(
          child: Semantics(
            button: true,
            label: 'Monto, mostrar teclado',
            child: GestureDetector(
              onTap: expense ? null : () => setState(() => _incomePad = true),
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
            child: caption == null
                ? null
                : Text(caption, style: UiTypography.caption),
          ),
        ),
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Column(children: fields),
        ),
        // With the pad open the destination cards would push the SaveBar off screen.
        if (!expense && !_padVisible) ...[
          const SizedBox(height: 18),
          Text('¿A dónde va?', style: UiTypography.title),
          const SizedBox(height: 10),
          UiChoiceCard(
            icon: UiIcons.inbox,
            title: 'Listo para asignar',
            description: 'Recomendado. Lo repartís después.',
            selected: !draft.incomeToEnvelope,
            onTap: draft.chooseReadyToAssign,
          ),
          const SizedBox(height: 10),
          UiChoiceCard(
            icon: UiIcons.wallet,
            title: 'Directo a un sobre',
            description:
                draft.incomeToEnvelope && draft.incomeEnvelopeId != null
                ? _envelopeName(draft.incomeEnvelopeId)
                : 'Para reintegros de un gasto puntual.',
            selected: draft.incomeToEnvelope,
            onTap: () {
              draft.chooseIncomeEnvelope();
              _pickEnvelope();
            },
          ),
        ],
        if (_padVisible) ...[
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
            label: expense ? 'Guardar gasto' : 'Guardar ingreso',
            enabled: !_saving,
            leadingIcon: expense ? UiIcons.split : UiIcons.calculator,
            onConfirm: _save,
            onCalculatorPressed: expense
                ? _openSplit
                : () => setState(() => _incomePad = !_padVisible),
          ),
        ),
      ],
    );
  }
}

/// Sends [transaction] and, on success, refreshes the figures that change
/// (movements, envelopes, accounts) and shows "Movimiento guardado". Returns
/// whether it was saved; a failure shows its message through [onError] or a
/// toast. Shared by 07 / 09 and 08.
Future<bool> saveTransaction(
  BuildContext context, {
  required TransactionDraft draft,
  required NewTransaction transaction,
  required TransactionsController transactions,
  required EnvelopesController envelopes,
  required AccountsController accounts,
  required void Function(String message) onError,
}) async {
  final currency = draft.currency;
  try {
    final created = await transactions.create(transaction);
    await Future.wait([envelopes.load(), accounts.load()]);
    if (!context.mounted) return true;
    final amount = formatMoney(created.amountMinor, currency);
    showSaved(
      context,
      'Movimiento guardado',
      detail: created.isExpense ? '−$amount' : amount,
    );
    return true;
  } on ApiFailure catch (failure) {
    if (!context.mounted) return false;
    switch (failure.kind) {
      case ApiFailureKind.forbidden:
        showForbidden(context);
      case ApiFailureKind.conflict:
        onError('La cuenta está archivada.');
      case ApiFailureKind.notFound:
        onError('Un sobre, una cuenta o un beneficiario ya no existe.');
        envelopes.load();
        accounts.load();
      case ApiFailureKind.validation:
        onError(failure.formErrors.firstOrNull ?? 'Revisá los datos.');
      default:
        showConnectionProblem(context);
    }
    return false;
  }
}
