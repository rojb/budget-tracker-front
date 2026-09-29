import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth_controller.dart';
import '../features/home/home_page.dart';
import '../features/placeholder/placeholder_page.dart';
import 'dependencies.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login'; // 18 Acceso
  static const register = '/register'; // 19 Crear cuenta
  static const welcome = '/welcome'; // 34 Bienvenida
  static const home = '/home'; // 01/02 placeholder
  static const newPlan = '/plans/new'; // 20 placeholder
  static const joinPlan = '/plans/join'; // 30 placeholder
}

/// Routes by session state: without a session only 18 and 19 are reachable;
/// with one the auth screens redirect to home (or to 34 right after sign-up).
GoRouter createRouter(Dependencies dependencies) {
  final auth = dependencies.authController;
  const authRoutes = {AppRoutes.login, AppRoutes.register};

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: auth,
    redirect: (context, state) {
      final location = state.matchedLocation;
      switch (auth.status) {
        case SessionStatus.unknown:
          return location == AppRoutes.splash ? null : AppRoutes.splash;
        case SessionStatus.signedOut:
          return authRoutes.contains(location) ? null : AppRoutes.login;
        case SessionStatus.signedIn:
          if (location == AppRoutes.splash || authRoutes.contains(location)) {
            return auth.showWelcome ? AppRoutes.welcome : AppRoutes.home;
          }
          if (location == AppRoutes.welcome && !auth.showWelcome) {
            return AppRoutes.home;
          }
          return null;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Scaffold(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => PlaceholderPage(
          title: '18 Acceso',
          description: 'Pantalla en construcción.',
          actionLabel: 'Crear cuenta',
          onAction: () => context.go(AppRoutes.register),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => PlaceholderPage(
          title: '19 Crear cuenta',
          description: 'Pantalla en construcción.',
          actionLabel: 'Iniciar sesión',
          onAction: () => context.go(AppRoutes.login),
        ),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const PlaceholderPage(
          title: '34 Bienvenida',
          description: 'Pantalla en construcción.',
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) =>
            HomePage(controllerFactory: dependencies.createHomeController),
      ),
      GoRoute(
        path: AppRoutes.newPlan,
        builder: (context, state) => PlaceholderPage(
          title: '20 Nuevo plan',
          description: 'Llega con add-plans-and-accounts.',
          actionLabel: 'Ir al inicio',
          onAction: () => context.go(AppRoutes.home),
        ),
      ),
      GoRoute(
        path: AppRoutes.joinPlan,
        builder: (context, state) => PlaceholderPage(
          title: '30 Unirse a un plan',
          description: 'Llega con add-plan-sharing.',
          actionLabel: 'Ir al inicio',
          onAction: () => context.go(AppRoutes.home),
        ),
      ),
    ],
  );
}
