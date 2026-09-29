import '../core/api/api_gateway.dart';
import '../core/config.dart';
import '../core/session/session_storage.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/auth_repository.dart';
import '../features/home/home_controller.dart';

/// Composition root: builds the object graph once and hands dependencies to
/// widgets through constructors.
class Dependencies {
  const Dependencies({
    required this.config,
    required this.apiGateway,
    required this.sessionStorage,
    required this.authRepository,
    required this.authController,
  });

  factory Dependencies.create() {
    const config = AppConfig.fromEnvironment();
    final gateway = ApiGateway(baseUrl: config.apiBaseUrl);
    const storage = SecureSessionStorage();
    final repository = AuthRepository(gateway);
    return Dependencies(
      config: config,
      apiGateway: gateway,
      sessionStorage: storage,
      authRepository: repository,
      authController: AuthController(repository, storage, gateway),
    );
  }

  final AppConfig config;
  final ApiGateway apiGateway;
  final SessionStorage sessionStorage;
  final AuthRepository authRepository;

  /// Session state shared by the router and the auth screens.
  final AuthController authController;

  HomeController createHomeController() => HomeController();
}
