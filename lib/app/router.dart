import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../features/accounts/account_detail_page.dart';
import '../features/accounts/account_form_controller.dart';
import '../features/accounts/account_form_page.dart';
import '../features/accounts/archived_accounts_page.dart';
import '../features/accounts/transfer_page.dart';
import '../features/accounts/transfers_repository.dart';
import '../features/accounts/accounts_page.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/auth/welcome_page.dart';
import '../features/envelopes/assign_money_page.dart';
import '../features/envelopes/envelope_form_page.dart';
import '../features/envelopes/groups_page.dart';
import '../features/envelopes/plan_tab_page.dart';
import '../features/envelopes/template_page.dart';
import '../features/home/home_page.dart';
import '../features/payees/payee_form_page.dart';
import '../features/payees/payees_controller.dart';
import '../features/payees/payees_page.dart';
import '../features/payees/payees_repository.dart';
import '../features/placeholder/placeholder_page.dart';
import '../features/plans/new_plan_page.dart';
import '../features/plans/no_plan_page.dart';
import '../features/plans/plans_controller.dart';
import '../features/plans/plans_page.dart';
import '../features/sharing/invite_controller.dart';
import '../features/sharing/invite_page.dart';
import '../features/sharing/join_link_page.dart';
import '../features/sharing/join_page.dart';
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
  final pending = dependencies.pendingInvite;
  const authRoutes = {AppRoutes.login, AppRoutes.register};
  const withoutPlan = {
    AppRoutes.start,
    AppRoutes.welcome,
    AppRoutes.newPlan,
    AppRoutes.joinPlan,
  };

  final rootKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: Listenable.merge([auth, plans]),
    redirect: (context, state) {
      final location = state.matchedLocation;
      // Parsed from the location: path parameters are not reliable here.
      final linkCode = location.startsWith(AppRoutes.joinLinkPrefix)
          ? location.substring(AppRoutes.joinLinkPrefix.length)
          : null;
      switch (auth.status) {
        case SessionStatus.unknown:
          return location == AppRoutes.splash ? null : AppRoutes.splash;
        case SessionStatus.signedOut:
          // An invitation link without a session: sign up first, then 45.
          if (linkCode != null) {
            pending.remember(linkCode);
            return AppRoutes.register;
          }
          return authRoutes.contains(location) ? null : AppRoutes.login;
        case SessionStatus.signedIn:
          final entering =
              location == AppRoutes.splash || authRoutes.contains(location);
          final pendingCode = pending.code;
          if (pendingCode != null && linkCode == null) {
            auth.consumeWelcome();
            return AppRoutes.joinLink(pendingCode);
          }
          // 45 consumes the pending code when it opens (the router can
          // evaluate the old location more than once per sign-in).
          if (linkCode != null) return null;
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
                builder: (context, state) => PlanTabPage(
                  plans: plans,
                  accounts: dependencies.accountsController,
                  envelopes: dependencies.envelopesController,
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
                builder: (context, state) => AccountsPage(
                  accounts: dependencies.accountsController,
                  plans: plans,
                ),
                routes: [
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: rootKey,
                    builder: (context, state) => AccountFormPage(
                      plans: plans,
                      controllerFactory: () => AccountFormController(
                        dependencies.accountsController,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'archived',
                    parentNavigatorKey: rootKey,
                    builder: (context, state) => ArchivedAccountsPage(
                      accounts: dependencies.accountsController,
                      plans: plans,
                    ),
                  ),
                  GoRoute(
                    path: ':accountId',
                    builder: (context, state) => AccountDetailPage(
                      accountId: state.pathParameters['accountId']!,
                      accounts: dependencies.accountsController,
                      plans: plans,
                      transfers: TransfersRepository(dependencies.apiGateway),
                    ),
                    routes: [
                      GoRoute(
                        path: 'transfer',
                        parentNavigatorKey: rootKey,
                        builder: (context, state) => TransferPage(
                          fromAccountId: state.pathParameters['accountId']!,
                          accounts: dependencies.accountsController,
                          plans: plans,
                          repository: TransfersRepository(
                            dependencies.apiGateway,
                          ),
                        ),
                      ),
                      GoRoute(
                        path: 'edit',
                        parentNavigatorKey: rootKey,
                        builder: (context, state) {
                          final accounts = dependencies.accountsController;
                          final account = accounts.byId(
                            state.pathParameters['accountId']!,
                          );
                          if (account == null) {
                            return _placeholder(
                              context,
                              'Cuenta no encontrada',
                              'Volvé a la lista de cuentas.',
                            );
                          }
                          return AccountFormPage(
                            plans: plans,
                            controllerFactory: () => AccountFormController(
                              accounts,
                              account: account,
                            ),
                            onArchive: (context) => confirmAndArchive(
                              context,
                              account,
                              () => accounts.archive(account.id),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.newPlan,
        builder: (context, state) => NewPlanPage(
          controllerFactory: dependencies.createNewPlanController,
        ),
      ),
      GoRoute(
        path: AppRoutes.plans,
        builder: (context, state) => PlansPage(
          plans: plans,
          auth: auth,
          sharing: dependencies.sharingRepository,
        ),
      ),
      GoRoute(
        path: AppRoutes.joinPlan,
        builder: (context, state) =>
            JoinPage(controllerFactory: dependencies.createJoinController),
      ),
      GoRoute(
        path: '${AppRoutes.joinLinkPrefix}:code',
        builder: (context, state) => JoinLinkPage(
          code: state.pathParameters['code']!,
          onOpen: pending.clear,
          repository: dependencies.sharingRepository,
          controllerFactory: dependencies.createJoinController,
        ),
      ),
      GoRoute(
        path: AppRoutes.invite,
        builder: (context, state) {
          final plan = plans.activePlan!;
          return InvitePage(
            planName: plan.name,
            controllerFactory: () =>
                InviteController(dependencies.sharingRepository, plan.id),
          );
        },
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
        path: AppRoutes.newEnvelope,
        builder: (context, state) => EnvelopeFormPage(
          envelopes: dependencies.envelopesController,
          initialGroupId: state.uri.queryParameters['groupId'],
        ),
      ),
      GoRoute(
        path: AppRoutes.groups,
        builder: (context, state) =>
            GroupsPage(envelopes: dependencies.envelopesController),
      ),
      GoRoute(
        path: AppRoutes.template,
        builder: (context, state) =>
            TemplatePage(envelopes: dependencies.envelopesController),
      ),
      GoRoute(
        path: AppRoutes.assignMoney,
        builder: (context, state) => AssignMoneyPage(
          plans: plans,
          envelopes: dependencies.envelopesController,
        ),
      ),
      GoRoute(
        path: '/envelopes/:envelopeId',
        builder: (context, state) => _placeholder(
          context,
          '22 Detalle de sobre',
          'Llega con add-envelope-goals.',
        ),
      ),
      ShellRoute(
        // One PayeesController per visit to 15, shared with 41.
        builder: (context, state, child) => _PayeesScope(
          create: () => PayeesController(
            PayeesRepository(dependencies.apiGateway),
            plans,
          ),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.payees,
            builder: (context, state) =>
                PayeesPage(controller: _PayeesScope.of(context)),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) =>
                    PayeeFormPage(controller: _PayeesScope.of(context)),
              ),
              GoRoute(
                path: ':payeeId',
                builder: (context, state) {
                  final controller = _PayeesScope.of(context);
                  return PayeeFormPage(
                    controller: controller,
                    payee: controller.byId(state.pathParameters['payeeId']!),
                  );
                },
              ),
            ],
          ),
        ],
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

/// Owns the [PayeesController] of one visit to 15 → 41.
class _PayeesScope extends StatefulWidget {
  const _PayeesScope({required this.create, required this.child});

  final PayeesController Function() create;
  final Widget child;

  static PayeesController of(BuildContext context) =>
      context.findAncestorStateOfType<_PayeesScopeState>()!.controller;

  @override
  State<_PayeesScope> createState() => _PayeesScopeState();
}

class _PayeesScopeState extends State<_PayeesScope> {
  late final PayeesController controller = widget.create();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
