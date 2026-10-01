import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../envelopes/envelopes_controller.dart';
import '../envelopes/goal_texts.dart';
import '../plans/plans_controller.dart';
import 'goal_options_sheet.dart';

/// Screen 05 Detalle de meta: the goal's photo (or the lavender tint) full
/// bleed under glass panels with the target, what is saved and what is missing,
/// four tiles and "Asignar a esta meta" (disabled here: it belongs to the
/// monthly assignment change). Every figure comes from the API's goal status.
class GoalDetailPage extends StatelessWidget {
  const GoalDetailPage({
    required this.envelopeId,
    required this.plans,
    required this.envelopes,
    super.key,
  });

  final String envelopeId;
  final PlansController plans;
  final EnvelopesController envelopes;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([plans, envelopes]),
      builder: (context, _) {
        final line = envelopes.lineById(envelopeId);
        final goal = line?.envelope.goal;
        final status = line?.goalStatus;
        if (line == null || goal == null || status == null) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiIconButton(
                      icon: UiIcons.chevronLeft,
                      variant: UiIconButtonVariant.soft,
                      semanticLabel: 'Volver',
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(height: 24),
                    Text('No encontramos la meta', style: UiTypography.title),
                  ],
                ),
              ),
            ),
          );
        }
        final currency = plans.currency;
        final canEdit = plans.activePlan?.canEdit ?? false;
        final image = envelopes.imageFor(line.envelope.photoUrl);
        final onPhoto = image != null;
        final text = onPhoto ? UiColors.surface : UiColors.ink;
        final months = monthsRemainingText(status);
        final icon = uiEnvelopeIcon(line.envelope.icon);
        Widget tile(IconData glyph, String label, VoidCallback onTap) =>
            Expanded(
              child: UiGlassTile(
                icon: glyph,
                label: label,
                onPhoto: onPhoto,
                onTap: onTap,
              ),
            );
        return AnnotatedRegion<SystemUiOverlayStyle>(
          // Light status bar icons over a photo, dark over the tint
          // (PRD-ux-spec.md 6.1 rule 8).
          value: onPhoto
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                UiGoalBackdrop(icon: icon, image: image),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      children: [
                        UiGlassPanel(
                          onPhoto: onPhoto,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              UiIconButton(
                                icon: UiIcons.chevronLeft,
                                variant: onPhoto
                                    ? UiIconButtonVariant.glass
                                    : UiIconButtonVariant.soft,
                                semanticLabel: 'Volver',
                                onPressed: () => context.pop(),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      line.envelope.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: UiTypography.custom(
                                        28,
                                        weight: 300,
                                        color: text,
                                      ),
                                    ),
                                    if (months.isNotEmpty)
                                      Text(
                                        months,
                                        style: UiTypography.custom(
                                          15,
                                          color: text,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (canEdit)
                                UiIconButton(
                                  icon: UiIcons.ellipsisVertical,
                                  variant: onPhoto
                                      ? UiIconButtonVariant.glass
                                      : UiIconButtonVariant.soft,
                                  semanticLabel: 'Opciones de la meta',
                                  onPressed: () => showGoalOptionsSheet(
                                    context,
                                    line: line,
                                    plans: plans,
                                    envelopes: envelopes,
                                  ),
                                )
                              else
                                const SizedBox(width: 52),
                            ],
                          ),
                        ),
                        const Spacer(),
                        UiGoalSummary(
                          targetLabel: formatMoney(goal.targetMinor, currency),
                          savedLabel: formatMoney(status.savedMinor, currency),
                          remainingLabel: formatMoney(
                            status.remainingMinor,
                            currency,
                          ),
                          progress: status.percent / 100,
                          onPhoto: onPhoto,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            tile(
                              UiIcons.history,
                              'Últimos aportes',
                              () => context.push(
                                AppRoutes.envelopeDetail(envelopeId),
                              ),
                            ),
                            const SizedBox(width: 12),
                            tile(
                              UiIcons.calendar,
                              'Plan de aportes',
                              () => context.push(
                                AppRoutes.envelopeDetail(envelopeId),
                              ),
                            ),
                          ],
                        ),
                        if (canEdit) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              tile(
                                UiIcons.arrowLeftRight,
                                'Mover dinero',
                                () => context.push(
                                  AppRoutes.moveMoney(envelopeId),
                                ),
                              ),
                              const SizedBox(width: 12),
                              tile(
                                UiIcons.target,
                                'Ajustar objetivo',
                                () => context.push(
                                  AppRoutes.editEnvelope(envelopeId),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 12),
                        UiButton(
                          label: 'Asignar a esta meta',
                          icon: UiIcons.sparkles,
                          onPressed: plans.activePlan?.canEdit ?? false
                              ? () => context.push(
                                  AppRoutes.assign(envelopeId: envelopeId),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
