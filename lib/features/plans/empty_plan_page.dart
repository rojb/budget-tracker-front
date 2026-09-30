import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../accounts/accounts_controller.dart';
import '../common/months.dart';
import 'plans_controller.dart';

/// Screen 06 Plan vacío: the Plan tab while the plan has no envelopes. With no
/// envelopes, Ready to Assign is exactly the sum of the account balances
/// (FR-11). `add-envelopes` replaces this tab with 02 once envelopes exist.
class EmptyPlanPage extends StatefulWidget {
  const EmptyPlanPage({required this.plans, required this.accounts, super.key});

  final PlansController plans;
  final AccountsController accounts;

  @override
  State<EmptyPlanPage> createState() => _EmptyPlanPageState();
}

class _EmptyPlanPageState extends State<EmptyPlanPage> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  void _shift(int delta) =>
      setState(() => _month = DateTime(_month.year, _month.month + delta));

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([widget.plans, widget.accounts]),
      builder: (context, _) {
        final currency = widget.plans.currency;
        final accounts = widget.accounts;
        return RefreshIndicator(
          onRefresh: accounts.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Row(
                children: [
                  Text('Plan', style: UiTypography.custom(36)),
                  if (currency != Currency.ars) ...[
                    const SizedBox(width: 10),
                    UiChip(
                      label: currency.symbol,
                      selected: true,
                      size: UiChipSize.compact,
                    ),
                  ],
                  const Spacer(),
                  UiIconButton(
                    icon: UiIcons.layers,
                    semanticLabel: 'Grupos',
                    onPressed: () => context.push(AppRoutes.groups),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              UiMonthSwitch(
                label: monthLabel(_month),
                onPrevious: () => _shift(-1),
                onNext: () => _shift(1),
              ),
              const SizedBox(height: 14),
              UiJoinedCard(
                primaryValue: formatMoney(accounts.totalMinor, currency),
                primaryLabel: 'Listo para asignar',
                secondaryValue: '0',
                secondaryLabel: 'Sobres activos',
                addLabel: 'Asignar dinero',
                addEnabled: false,
                onAdd: () {},
              ),
              const SizedBox(height: 14),
              UiCard(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Primeros pasos', style: UiTypography.custom(20)),
                    const SizedBox(height: 8),
                    const UiChecklistRow(
                      label: 'Creaste tu plan',
                      state: UiChecklistState.done,
                    ),
                    UiChecklistRow(
                      label: 'Agregá tus otras cuentas',
                      state: accounts.active.length > 1
                          ? UiChecklistState.done
                          : UiChecklistState.pending,
                      onTap: () => context.push(AppRoutes.newAccount),
                    ),
                    UiChecklistRow(
                      label: 'Creá tus sobres',
                      onTap: () => context.push(AppRoutes.template),
                    ),
                    UiChecklistRow(
                      label: 'Asigná tu dinero',
                      state: UiChecklistState.disabled,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final label in [
                          'Alquiler',
                          'Supermercado',
                          'Salidas',
                          'Emergencia',
                          '+8',
                        ])
                          UiChip(
                            label: label,
                            soft: true,
                            size: UiChipSize.compact,
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    UiButton(
                      label: 'Usar plantilla sugerida',
                      icon: UiIcons.wand,
                      onPressed: () => context.push(AppRoutes.template),
                    ),
                    const SizedBox(height: 10),
                    UiButton(
                      label: 'Crear sobre vacío',
                      icon: UiIcons.plus,
                      variant: UiButtonVariant.secondary,
                      onPressed: () => context.push(AppRoutes.newEnvelope),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
