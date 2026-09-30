import '../core/api/api_gateway.dart';
import '../core/config.dart';
import '../core/plan/active_plan_storage.dart';
import '../core/session/session_storage.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/auth_repository.dart';
import '../features/auth/login_controller.dart';
import '../features/auth/register_controller.dart';
import '../features/home/home_controller.dart';
import '../features/plans/plans_controller.dart';
import '../features/plans/plans_repository.dart';

/// Composition root: builds the object graph once and hands dependencies to
/// widgets through constructors.
class Dependencies {
  const Dependencies({
    required this.config,
    required this.apiGateway,
    required this.sessionStorage,
    required this.authRepository,
    required this.authController,
    required this.plansController,
  });

  factory Dependencies.create() {
    const config = AppConfig.fromEnvironment();
    final gateway = ApiGateway(baseUrl: config.apiBaseUrl);
    const storage = SecureSessionStorage();
    final repository = AuthRepository(gateway);
    final auth = AuthController(repository, storage, gateway);
    return Dependencies(
      config: config,
      apiGateway: gateway,
      sessionStorage: storage,
      authRepository: repository,
      authController: auth,
      plansController: PlansController(
        PlansRepository(gateway),
        const SecureActivePlanStorage(),
        auth,
      ),
    );
  }

  final AppConfig config;
  final ApiGateway apiGateway;
  final SessionStorage sessionStorage;
  final AuthRepository authRepository;

  /// Session state shared by the router and the auth screens.
  final AuthController authController;

  /// The user's plans and the active one, shared by the router and screens.
  final PlansController plansController;

  LoginController createLoginController() => LoginController(authController);

  RegisterController createRegisterController() =>
      RegisterController(authController);

  HomeController createHomeController() =>
      HomeController(authController, plansController);
}
