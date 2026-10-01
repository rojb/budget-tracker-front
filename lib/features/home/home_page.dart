import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../envelopes/envelopes_controller.dart';
import '../envelopes/goal_texts.dart';
import '../plans/plans_controller.dart';
import '../shell/account_menu_sheet.dart';
import 'home_controller.dart';

/// Screen 01 Inicio: the avatar (→ 39), the greeting and the "Metas" carousel
/// of this change (a `GoalCard` per envelope with a goal that has a date → 05,
/// "+ Nueva meta" → 31 with the group Metas and "Con fecha"). The Ready to
/// Assign card and its "+" (`add-monthly-assignment`) and Reportes (`add-reports`)
/// are not built here.
class HomePage extends StatefulWidget {
  const HomePage({
    required this.controllerFactory,
    required this.menu,
    required this.plans,
    required this.envelopes,
    super.key,
  });

  final HomeController Function() controllerFactory;
  final AccountMenu menu;
  final PlansController plans;
  final EnvelopesController envelopes;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller = widget.controllerFactory();
  final PageController _pages = PageController(viewportFraction: 0.82);
  int _page = 0;

  @override
  void dispose() {
    _pages.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _newGoal() =>
      context.push(AppRoutes.newGoal(groupId: _controller.goalsGroupId));

  Widget _goals() {
    final currency = widget.plans.currency;
    if (_controller.loadingGoals) return const _GoalsSkeleton();
    if (_controller.goalsFailed) {
      return UiCard(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('No pudimos cargar tus metas', style: UiTypography.title),
            const SizedBox(height: 8),
            Text(
              'Revisá tu conexión e intentá de nuevo.',
              style: UiTypography.custom(15, color: UiColors.inkMuted),
            ),
            const SizedBox(height: 16),
            UiButton(label: 'Reintentar', onPressed: _controller.retryGoals),
          ],
        ),
      );
    }
    final goals = _controller.goals;
    if (goals.isEmpty) {
      return _NewGoalCard(label: 'Creá tu primera meta', onTap: _newGoal);
    }
    final count = goals.length + 1;
    return Column(
      children: [
        SizedBox(
          height: 310,
          child: PageView.builder(
            controller: _pages,
            itemCount: count,
            onPageChanged: (index) => setState(() => _page = index),
            itemBuilder: (context, index) {
              if (index == goals.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _NewGoalCard(label: '+ Nueva meta', onTap: _newGoal),
                );
              }
              final line = goals[index];
              final goal = line.envelope.goal!;
              final status = line.goalStatus;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: UiGoalCard(
                  name: line.envelope.name,
                  subtitle: goalSubtitle(goal, currency),
                  savedLabel: formatMoney(status?.savedMinor ?? 0, currency),
                  percent: status?.percent ?? 0,
                  icon: uiEnvelopeIcon(line.envelope.icon),
                  image: widget.envelopes.imageFor(line.envelope.photoUrl),
                  onTap: () =>
                      context.push(AppRoutes.goalDetail(line.envelope.id)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        UiPageDots(count: count, index: _page.clamp(0, count - 1)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Row(
            children: [
              Semantics(
                button: true,
                label: 'Menú de cuenta',
                child: GestureDetector(
                  onTap: () => widget.menu.show(context),
                  child: ExcludeSemantics(
                    child: UiAvatar(initials: _controller.initials),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(_controller.greeting, style: UiTypography.headline),
          if (_controller.planName != null) ...[
            const SizedBox(height: 6),
            Text(_controller.planName!, style: UiTypography.caption),
          ],
          const SizedBox(height: 28),
          Text('Metas', style: UiTypography.custom(28)),
          const SizedBox(height: 14),
          _goals(),
        ],
      ),
    );
  }
}

/// "+ Nueva meta" (and "Creá tu primera meta" when there are no goals): a
/// lavender card that opens 31 with the group Metas and "Con fecha".
class _NewGoalCard extends StatelessWidget {
  const _NewGoalCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: UiColors.lavender,
              borderRadius: BorderRadius.circular(UiRadius.photo),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: UiColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    UiIcons.plus,
                    size: 28,
                    color: UiColors.ink,
                  ),
                ),
                const SizedBox(height: 16),
                Text(label, style: UiTypography.custom(22)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Loading placeholder with the shape of a goal card (PRD-ux-spec.md 5).
class _GoalsSkeleton extends StatelessWidget {
  const _GoalsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cargando tus metas',
      child: ExcludeSemantics(
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: UiColors.soft,
            borderRadius: BorderRadius.circular(UiRadius.photo),
          ),
        ),
      ),
    );
  }
}
