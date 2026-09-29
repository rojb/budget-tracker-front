import '../core/config.dart';
import '../features/home/home_controller.dart';

/// Composition root: builds the object graph once and hands dependencies to
/// widgets through constructors. Later changes add the API client and
/// repositories here.
class Dependencies {
  const Dependencies({required this.config});

  factory Dependencies.create() {
    return const Dependencies(config: AppConfig.fromEnvironment());
  }

  final AppConfig config;

  HomeController createHomeController() => HomeController();
}
