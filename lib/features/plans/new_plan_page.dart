import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import 'new_plan_controller.dart';

/// Screen 20 Nuevo plan: name, immutable currency (FR-40) and first account.
class NewPlanPage extends StatefulWidget {
  const NewPlanPage({required this.controllerFactory, super.key});

  final NewPlanController Function() controllerFactory;

  @override
  State<NewPlanPage> createState() => _NewPlanPageState();
}

class _NewPlanPageState extends State<NewPlanPage> {
  late final NewPlanController _controller = widget.controllerFactory();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _editName() async {
    final value = await showTextEditSheet(
      context,
      title: 'Nombre del plan',
      label: 'Nombre',
      initial: _controller.name,
    );
    if (value != null) _controller.setName(value);
  }

  Future<void> _editAccountName() async {
    final value = await showTextEditSheet(
      context,
      title: 'Nombre de la cuenta',
      label: 'Nombre',
      initial: _controller.accountName,
    );
    if (value != null) _controller.setAccountName(value);
  }

  Future<void> _editBalance() async {
    final value = await showAmountSheet(
      context,
      title: 'Saldo inicial',
      currency: _controller.currency,
      initialMinor: _controller.openingBalanceMinor,
    );
    if (value != null) _controller.setOpeningBalance(value);
  }

  Future<void> _submit() async {
    final outcome = await _controller.submit();
    if (!mounted) return;
    switch (outcome) {
      case NewPlanOutcome.created:
        showSaved(context, 'Plan creado');
        context.go(AppRoutes.plan);
      case NewPlanOutcome.invalid:
        break;
      case NewPlanOutcome.forbidden:
        showForbidden(context);
      case NewPlanOutcome.connectionProblem:
        showConnectionProblem(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UiIconButton(
                        icon: UiIcons.chevronLeft,
                        variant: UiIconButtonVariant.soft,
                        semanticLabel: 'Volver',
                        onPressed: () => context.canPop()
                            ? context.pop()
                            : context.go(AppRoutes.home),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text('Nuevo plan', style: UiTypography.custom(36)),
                    const SizedBox(height: 6),
                    Text(
                      'Un espacio para tus cuentas y sobres.',
                      style: UiTypography.custom(15, color: UiColors.inkMuted),
                    ),
                    const SizedBox(height: 18),
                    UiCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      child: UiFieldRow(
                        label: 'Nombre del plan',
                        value: _controller.name,
                        onTap: _editName,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Moneda', style: UiTypography.title),
                    const SizedBox(height: 12),
                    UiCurrencySelector(
                      selected: _controller.currency,
                      onChanged: _controller.setCurrency,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'No se puede cambiar después de crear el plan.',
                      style: UiTypography.caption,
                    ),
                    const SizedBox(height: 22),
                    Text('Primera cuenta', style: UiTypography.title),
                    const SizedBox(height: 12),
                    UiCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          UiFieldRow(
                            label: 'Nombre de la cuenta',
                            value: _controller.accountName,
                            onTap: _editAccountName,
                          ),
                          UiFieldRow(
                            label: 'Saldo inicial',
                            value: formatMoney(
                              _controller.openingBalanceMinor,
                              _controller.currency,
                            ),
                            onTap: _editBalance,
                          ),
                        ],
                      ),
                    ),
                    if (_controller.error != null) ...[
                      const SizedBox(height: 12),
                      UiFormMessage(message: _controller.error!),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: UiSaveBar(
                  label: _controller.saving ? 'Creando…' : 'Crear plan',
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
