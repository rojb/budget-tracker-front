/// Build-time configuration, injected with `--dart-define`.
///
/// Example: `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000`
class AppConfig {
  const AppConfig({required this.apiBaseUrl});

  /// Reads values from `--dart-define`. `10.0.2.2` is the Android emulator's
  /// alias for the host machine (backend or Prism mock).
  const AppConfig.fromEnvironment()
      : apiBaseUrl = const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'http://10.0.2.2:3000',
        );

  final String apiBaseUrl;
}
