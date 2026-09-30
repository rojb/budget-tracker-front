import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../features/auth/auth_controller.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/auth/welcome_page.dart';
import '../features/home/home_page.dart';
import '../features/placeholder/placeholder_page.dart';
import '../features/plans/no_plan_page.dart';
import '../features/plans/plans_controller.dart';
import '../features/shell/account_menu_sheet.dart';
import '../features/shell/app_shell.dart';
import 'dependencies.dart';
import 'routes.dart';

export 'routes.dart';

/// Routes by session and plan state: without a session only 18 and 19 are
/// reachable; signed in, the app waits for the plans, sends a user without
/// plans to create or join one, and otherwise opens the tabs.
GoRouter createRouter(Dependencies dependencies) {
  final auth = dependencies.authController;
  final plans = dependencies.plansController;
  const authRoutes = {AppRoutes.login, AppRoutes.register};
  const withoutPlan = {
    AppRoutes.start,
    AppRoutes.welcome,
    AppRoutes.newPlan,
    AppRoutes.joinPlan,
  };

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: Listenable.merge([auth, plans]),
    redirect: (context, state) {
      final location = state.matchedLocation;
      switch (auth.status) {
        case SessionStatus.unknown:
          return location == AppRoutes.splash ? null : AppRoutes.splash;
        case SessionStatus.signedOut:
          return authRoutes.contains(location) ? null : AppRoutes.login;
        case SessionStatus.signedIn:
          final entering =
              location == AppRoutes.splash || authRoutes.contains(location);
          if (auth.showWelcome) {
            return entering ? AppRoutes.welcome : null;
          }
          if (location == AppRoutes.welcome) return AppRoutes.home;
          if (plans.status != PlansStatus.ready) {
            return location == AppRoutes.splash ? null : AppRoutes.splash;
          }
          if (!plans.hasPlans) {
            return withoutPlan.contains(location) ? null : AppRoutes.start;
          }
          if (entering || location == AppRoutes.start) return AppRoutes.home;
          return null;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => _SplashPage(plans: plans),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) =>
            LoginPage(controllerFactory: dependencies.createLoginController),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterPage(
          controllerFactory: dependencies.createRegisterController,
        ),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => WelcomePage(auth: auth),
      ),
      GoRoute(
        path: AppRoutes.start,
        builder: (context, state) => NoPlanPage(onSignOut: auth.logout),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => HomePage(
                  controllerFactory: dependencies.createHomeController,
                  menu: AccountMenu(auth),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.plan,
                builder: (context, state) => const PlaceholderPage(
                  title: '06 Plan vacío',
                  description:
                      'Llega en la tarea 3.7 de add-plans-and-accounts.',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.transactions,
                builder: (context, state) => const PlaceholderPage(
                  title: '10 Movimientos',
                  description: 'Llega con add-transactions.',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.accounts,
                builder: (context, state) => const PlaceholderPage(
                  title: '13 Cuentas',
                  description:
                      'Llega en la tarea 3.9 de add-plans-and-accounts.',
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.newPlan,
        builder: (context, state) => _placeholder(
          context,
          '20 Nuevo plan',
          'Llega en la tarea 3.7 de add-plans-and-accounts.',
        ),
      ),
      GoRoute(
        path: AppRoutes.plans,
        builder: (context, state) => _placeholder(
          context,
          '16 Planes y miembros',
          'Llega en la tarea 3.8 de add-plans-and-accounts.',
        ),
      ),
      GoRoute(
        path: AppRoutes.joinPlan,
        builder: (context, state) => _placeholder(
          context,
          '30 Unirse a un plan',
          'Llega con add-plan-sharing.',
        ),
      ),
      GoRoute(
        path: AppRoutes.invite,
        builder: (context, state) => _placeholder(
          context,
          '21 Invitar miembro',
          'Llega con add-plan-sharing.',
        ),
      ),
      GoRoute(
        path: AppRoutes.newTransaction,
        builder: (context, state) => _placeholder(
          context,
          '07 Nuevo movimiento',
          'Llega con add-transactions.',
        ),
      ),
      GoRoute(
        path: AppRoutes.payees,
        builder: (context, state) =>
            _placeholder(context, '15 Beneficiarios', 'Llega con add-payees.'),
      ),
    ],
  );
}

/// Pushed stand-in for a screen a later change builds, with a way back.
Widget _placeholder(BuildContext context, String title, String description) {
  return PlaceholderPage(
    title: title,
    description: description,
    actionLabel: 'Volver',
    actionIcon: UiIcons.chevronLeft,
    onAction: () =>
        context.canPop() ? context.pop() : context.go(AppRoutes.home),
  );
}

/// Blank while the session and the plans load; offers a retry if the plans
/// could not be loaded.
class _SplashPage extends StatelessWidget {
  const _SplashPage({required this.plans});

  final PlansController plans;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: plans,
        builder: (context, _) {
          if (plans.status != PlansStatus.failed) return const SizedBox();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'No pudimos cargar tus planes',
                    style: UiTypography.title,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Revisá tu conexión e intentá de nuevo.',
                    style: UiTypography.custom(16, color: UiColors.inkMuted),
                  ),
                  const SizedBox(height: 24),
                  UiButton(label: 'Reintentar', onPressed: plans.load),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
