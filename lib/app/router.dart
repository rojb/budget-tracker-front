import 'package:go_router/go_router.dart';

import '../features/home/home_page.dart';
import 'dependencies.dart';

GoRouter createRouter(Dependencies dependencies) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            HomePage(controllerFactory: dependencies.createHomeController),
      ),
    ],
  );
}
