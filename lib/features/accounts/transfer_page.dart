import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/date_time_sheet.dart';
import '../common/dates.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import 'account_picker.dart';
import 'accounts_controller.dart';
import 'accounts_repository.dart';
import 'transfers_repository.dart';

/// Screen 29 Transferencia: money between two accounts, without envelopes.
class TransferPage extends StatefulWidget {
  const TransferPage({
    required this.fromAccountId,
    required this.accounts,
    required this.plans,
    required this.repository,
    super.key,
  });

  final String fromAccountId;
  final AccountsController accounts;
  final PlansController plans;
  final TransfersRepository repository;

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late String? _fromId = widget.fromAccountId;
  late String? _toId = widget.accounts.active
      .where((a) => a.id != widget.fromAccountId)
      .firstOrNull
      ?.id;
  int _amountMinor = 0;
  DateTime _occurredAt = DateTime.now();
  String? _error;
  bool _saving = false;

  Currency get _currency => widget.plans.currency;

  Future<void> _pick({required bool from}) async {
    final picked = await showAccountPicker(
      context,
      accounts: widget.accounts,
      currency: _currency,
      selectedId: from ? _fromId : _toId,
      exclude: {?(from ? _toId : _fromId)},
    );
    if (picked == null) return;
    setState(() {
      if (from) {
        _fromId = picked.id;
      } else {
        _toId = picked.id;
      }
      _error = null;
    });
  }

  Future<void> _editAmount() async {
    final value = await showAmountSheet(
      context,
      title: 'Monto',
      currency: _currency,
      initialMinor: _amountMinor,
    );
    if (value != null) {
      setState(() {
        _amountMinor = value;
        _error = null;
      });
    }
  }

  Future<void> _editDate() async {
    final value = await showDateTimeSheet(context, _occurredAt);
    if (value != null) setState(() => _occurredAt = value);
  }

  Future<void> _save() async {
    if (_saving) return;
    if (_amountMinor <= 0) {
      setState(() => _error = 'Ingresá un monto mayor a cero.');
      return;
    }
    if (_fromId == null || _toId == null) return;
    setState(() => _saving = true);
    try {
      await widget.repository.create(
        widget.plans.activePlan!.id,
        fromAccountId: _fromId!,
        toAccountId: _toId!,
        amountMinor: _amountMinor,
        occurredAt: _occurredAt,
      );
      await widget.accounts.load();
      if (!mounted) return;
      showSaved(context, 'Transferencia guardada');
      context.pop();
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.forbidden:
          showForbidden(context);
        case ApiFailureKind.conflict:
          setState(() => _error = 'Una de las cuentas está archivada.');
        case ApiFailureKind.validation:
          setState(() => _error = failure.formErrors.firstOrNull);
        default:
          showConnectionProblem(context);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _accountCard(AccountData? account, {required bool from}) {
    if (account == null) {
      return UiCard(
        child: UiFieldRow(
          label: from ? 'Elegí la cuenta de origen' : 'Elegí la cuenta destino',
          value: '',
          onTap: () => _pick(from: from),
        ),
      );
    }
    final share = widget.accounts.shareOf(account);
    return UiCard(
      child: UiAccountRow(
        icon: account.kind.icon,
        name: account.name,
        subtitle: account.kind.label,
        amount: formatMoney(account.balanceMinor, _currency),
        caption: '${(share * 100).round()}% del total',
        onTap: () => _pick(from: from),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = widget.accounts;
    final from = _fromId == null ? null : accounts.byId(_fromId!);
    final to = _toId == null ? null : accounts.byId(_toId!);
    final enough = accounts.active.length >= 2;
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            Text('Transferencia', style: UiTypography.custom(36)),
            const SizedBox(height: 14),
            if (!enough) ...[
              const UiInfoNote(
                text:
                    'Para transferir necesitás al menos dos cuentas activas en '
                    'el plan.',
              ),
              const SizedBox(height: 14),
              UiButton(
                label: 'Agregar cuenta',
                icon: UiIcons.plus,
                onPressed: () => context.push(AppRoutes.newAccount),
              ),
            ] else ...[
              Text(
                'Desde',
                style: UiTypography.custom(15, color: UiColors.inkMuted),
              ),
              const SizedBox(height: 8),
              _accountCard(from, from: true),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Icon(
                  UiIcons.arrowDown,
                  size: 20,
                  color: UiColors.inkMuted,
                ),
              ),
              Text(
                'Hacia',
                style: UiTypography.custom(15, color: UiColors.inkMuted),
              ),
              const SizedBox(height: 8),
              _accountCard(to, from: false),
              const SizedBox(height: 14),
              Center(
                child: Semantics(
                  button: true,
                  label: 'Monto, editar',
                  child: GestureDetector(
                    onTap: _editAmount,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: UiAmountCapsule(
                        symbol: _currency.symbol,
                        value: formatAmountValue(_amountMinor, _currency),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              UiCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child: UiFieldRow(
                  label: 'Fecha y hora',
                  value: dateTimeLabel(_occurredAt),
                  onTap: _editDate,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Una transferencia no usa sobres.',
                style: UiTypography.caption,
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                UiFormMessage(message: _error!),
              ],
              const SizedBox(height: 14),
              UiSaveBar(
                label: 'Transferir',
                enabled: !_saving,
                onConfirm: _save,
                onCalculatorPressed: _editAmount,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
