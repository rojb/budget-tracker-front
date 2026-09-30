import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../auth/auth_controller.dart';
import 'plans_controller.dart';
import 'plans_repository.dart';

/// Screen 16 Planes y miembros: the user's plans (tap to make one active) and
/// the members of the active plan. Invitations arrive with add-plan-sharing.
class PlansPage extends StatelessWidget {
  const PlansPage({required this.plans, required this.auth, super.key});

  final PlansController plans;
  final AuthController auth;

  static const Map<Currency, String> _currencyNames = {
    Currency.ars: r'pesos ($)',
    Currency.usd: r'dólares (US$)',
    Currency.eur: 'euros (€)',
  };

  static String roleLabel(PlanRole role) => switch (role) {
    PlanRole.owner => 'Titular',
    PlanRole.editor => 'Puede editar',
    PlanRole.viewer => 'Solo lectura',
  };

  String _subtitle(PlanData plan) {
    final who = plan.members.length <= 1
        ? 'Solo vos'
        : 'Compartido · ${plan.members.length} miembros';
    return '$who · ${_currencyNames[plan.currency]}';
  }

  Future<void> _open(BuildContext context, PlanData plan) async {
    await plans.select(plan.id);
    if (context.mounted) context.go(AppRoutes.plan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: plans,
          builder: (context, _) {
            final active = plans.activePlan;
            final me = auth.user?.id;
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
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
                Text('Planes y miembros', style: UiTypography.custom(36)),
                const SizedBox(height: 18),
                for (final plan in plans.plans) ...[
                  UiPlanRow(
                    title: plan.name,
                    subtitle: _subtitle(plan),
                    active: plan.id == active?.id,
                    icon: plan.id == active?.id ? UiIcons.wallet : null,
                    initials: [
                      for (final m in plan.members.take(2)) m.initials,
                    ],
                    onTap: () => _open(context, plan),
                  ),
                  const SizedBox(height: 10),
                ],
                Row(
                  children: [
                    Expanded(
                      child: UiButton(
                        label: 'Nuevo plan',
                        icon: UiIcons.plus,
                        variant: UiButtonVariant.white,
                        onPressed: () => context.push(AppRoutes.newPlan),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: UiButton(
                        label: 'Unirme con código',
                        icon: UiIcons.keyRound,
                        variant: UiButtonVariant.white,
                        onPressed: () => context.push(AppRoutes.joinPlan),
                      ),
                    ),
                  ],
                ),
                if (active != null) ...[
                  const SizedBox(height: 26),
                  Text('Miembros · ${active.name}', style: UiTypography.title),
                  const SizedBox(height: 12),
                  UiCard(
                    child: Column(
                      children: [
                        for (final (i, member) in active.members.indexed)
                          UiMemberRow(
                            initials: member.initials,
                            name: member.userId == me
                                ? '${member.name} (vos)'
                                : member.name,
                            email: member.email,
                            role: roleLabel(member.role),
                            avatarColor: i == 0
                                ? UiColors.lavender
                                : UiColors.chartreuse,
                          ),
                        if (active.myRole == PlanRole.owner) ...[
                          const SizedBox(height: 14),
                          UiButton(
                            label: 'Invitar con código',
                            icon: UiIcons.qrCode,
                            onPressed: () => context.push(AppRoutes.invite),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  UiInfoNote(
                    icon: UiIcons.lock,
                    text: active.myRole == PlanRole.owner
                        ? 'Quienes pueden editar cargan movimientos y asignan, '
                              'pero solo vos invitás, quitás miembros o borrás '
                              'el plan.'
                        : 'Podés ver este plan${active.canEdit ? ', cargar movimientos y asignar' : ''}; '
                              'solo quien lo administra invita, quita miembros '
                              'o lo borra.',
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
