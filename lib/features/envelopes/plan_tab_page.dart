import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../accounts/accounts_controller.dart';
import '../plans/empty_plan_page.dart';
import '../plans/plans_controller.dart';
import 'envelopes_controller.dart';
import 'plan_page.dart';

/// Content of the Plan tab: 06 Plan vacío while the plan has no envelopes and 02
/// Plan del mes as soon as it has one.
class PlanTabPage extends StatelessWidget {
  const PlanTabPage({
    required this.plans,
    required this.accounts,
    required this.envelopes,
    super.key,
  });

  final PlansController plans;
  final AccountsController accounts;
  final EnvelopesController envelopes;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: envelopes,
      builder: (context, _) {
        if (!envelopes.loaded) {
          if (!envelopes.failed) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('No pudimos cargar tu plan', style: UiTypography.title),
                const SizedBox(height: 8),
                Text(
                  'Revisá tu conexión e intentá de nuevo.',
                  style: UiTypography.custom(16, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 24),
                UiButton(label: 'Reintentar', onPressed: envelopes.load),
              ],
            ),
          );
        }
        if (envelopes.envelopeCount == 0) {
          return EmptyPlanPage(plans: plans, accounts: accounts);
        }
        return PlanPage(plans: plans, envelopes: envelopes);
      },
    );
  }
}
