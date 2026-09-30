import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import 'account_form_controller.dart';
import 'accounts_repository.dart';
import 'archive_account_sheet.dart';

/// Screens 28 Nueva cuenta and 42 Editar cuenta (same form; 42 is prefilled
/// and offers the archive action in the top bar).
class AccountFormPage extends StatefulWidget {
  const AccountFormPage({
    required this.controllerFactory,
    required this.plans,
    this.onArchive,
    super.key,
  });

  final AccountFormController Function() controllerFactory;
  final PlansController plans;

  /// 42 only: archives the account after the 48 confirmation.
  final Future<bool> Function(BuildContext context)? onArchive;

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage> {
  late final AccountFormController _controller = widget.controllerFactory();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _editName() async {
    final value = await showTextEditSheet(
      context,
      title: 'Nombre de la cuenta',
      label: 'Nombre',
      initial: _controller.name,
    );
    if (value != null) _controller.setName(value);
  }

  Future<void> _editBalance() async {
    final value = await showAmountSheet(
      context,
      title: 'Saldo inicial',
      currency: widget.plans.currency,
      initialMinor: _controller.openingBalanceMinor,
    );
    if (value != null) _controller.setOpeningBalance(value);
  }

  Future<void> _submit() async {
    final outcome = await _controller.submit();
    if (!mounted) return;
    switch (outcome) {
      case AccountFormOutcome.saved:
        showSaved(context, 'Guardado');
        context.pop();
      case AccountFormOutcome.invalid:
        break;
      case AccountFormOutcome.forbidden:
        showForbidden(context);
      case AccountFormOutcome.connectionProblem:
        showConnectionProblem(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currency = widget.plans.currency;
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
                        if (widget.onArchive != null)
                          UiIconButton(
                            icon: UiIcons.archive,
                            variant: UiIconButtonVariant.danger,
                            semanticLabel: 'Archivar cuenta',
                            onPressed: () async {
                              final archived = await widget.onArchive!(context);
                              if (archived && context.mounted) {
                                context.go(AppRoutes.accounts);
                              }
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      _controller.editing ? 'Editar cuenta' : 'Nueva cuenta',
                      style: UiTypography.custom(36),
                    ),
                    const SizedBox(height: 18),
                    UiCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      child: UiFieldRow(
                        label: 'Nombre',
                        value: _controller.name.isEmpty
                            ? 'Elegí un nombre'
                            : _controller.name,
                        onTap: _editName,
                      ),
                    ),
                    if (_controller.nameError != null) ...[
                      const SizedBox(height: 8),
                      UiFormMessage(message: _controller.nameError!),
                    ],
                    const SizedBox(height: 22),
                    Text('Tipo', style: UiTypography.custom(17)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final kind in AccountKind.values)
                          UiChip(
                            label: kind.label,
                            selected: kind == _controller.kind,
                            onPressed: () => _controller.setKind(kind),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Saldo inicial',
                      style: UiTypography.custom(15, color: UiColors.inkMuted),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Semantics(
                        button: true,
                        label: 'Saldo inicial, editar',
                        child: GestureDetector(
                          onTap: _editBalance,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: UiAmountCapsule(
                              symbol: currency.symbol,
                              value: formatAmountValue(
                                _controller.openingBalanceMinor,
                                currency,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_controller.formError != null) ...[
                      const SizedBox(height: 12),
                      UiFormMessage(message: _controller.formError!),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: UiSaveBar(
                  label: _controller.editing
                      ? 'Guardar cambios'
                      : 'Crear cuenta',
                  enabled: !_controller.saving,
                  onConfirm: _submit,
                  onCalculatorPressed: _editBalance,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens 48 for [account] and archives it on confirmation. True if archived.
Future<bool> confirmAndArchive(
  BuildContext context,
  AccountData account,
  Future<void> Function() archive,
) async {
  final confirmed = await showArchiveAccountSheet(context, account);
  if (confirmed != true || !context.mounted) return false;
  try {
    await archive();
    return true;
  } catch (_) {
    if (context.mounted) showConnectionProblem(context);
    return false;
  }
}
