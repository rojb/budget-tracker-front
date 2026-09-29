import '../core/api/api_gateway.dart';
import '../core/config.dart';
import '../core/session/session_storage.dart';
import '../features/home/home_controller.dart';

/// Composition root: builds the object graph once and hands dependencies to
/// widgets through constructors.
class Dependencies {
  const Dependencies({
    required this.config,
    required this.apiGateway,
    required this.sessionStorage,
  });

  factory Dependencies.create() {
    const config = AppConfig.fromEnvironment();
    return Dependencies(
      config: config,
      apiGateway: ApiGateway(baseUrl: config.apiBaseUrl),
      sessionStorage: const SecureSessionStorage(),
    );
  }

  final AppConfig config;
  final ApiGateway apiGateway;
  final SessionStorage sessionStorage;

  HomeController createHomeController() => HomeController();
}
