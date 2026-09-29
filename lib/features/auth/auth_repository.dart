import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

import '../../core/api/api_gateway.dart';

/// The signed-in person, as the app needs to show it.
class AuthUser {
  const AuthUser({required this.id, required this.name, required this.email});

  factory AuthUser.fromApi(User user) =>
      AuthUser(id: user.id, name: user.name, email: user.email);

  final String id;
  final String name;
  final String email;
}

class AuthSessionData {
  const AuthSessionData({required this.token, required this.user});

  final String token;
  final AuthUser user;
}

enum AuthFailureKind {
  /// Login with wrong email or password (`401`).
  invalidCredentials,

  /// Register with an email that already has an account (`409`).
  emailTaken,

  /// The API rejected the payload (`400`); see [AuthFailure.fieldErrors].
  validation,

  /// The API could not be reached.
  network,

  /// The stored token was rejected (`401` on a secured call).
  unauthorized,

  /// Anything else (`5xx`, unexpected payload).
  unexpected,
}

/// Domain error raised by [AuthRepository]; controllers turn it into field
/// errors, a form message or a toast.
class AuthFailure implements Exception {
  const AuthFailure(
    this.kind, {
    this.fieldErrors = const {},
    this.formErrors = const [],
  });

  final AuthFailureKind kind;

  /// Validation messages by field name (`name`, `email`, `password`).
  final Map<String, String> fieldErrors;

  /// Validation messages that do not belong to a known field.
  final List<String> formErrors;

  @override
  String toString() => 'AuthFailure($kind, $fieldErrors, $formErrors)';
}

/// Wraps the generated `AuthApi`/`UsersApi` and maps transport errors to
/// [AuthFailure].
class AuthRepository {
  AuthRepository(this._gateway);

  final ApiGateway _gateway;

  Future<AuthSessionData> login({
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final response = await _gateway.client.getAuthApi().login(
        loginRequest: LoginRequest(
          (b) => b
            ..email = email
            ..password = password,
        ),
      );
      return _toSession(response.data);
    });
  }

  Future<AuthSessionData> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final response = await _gateway.client.getAuthApi().register(
        registerRequest: RegisterRequest(
          (b) => b
            ..name = name
            ..email = email
            ..password = password,
        ),
      );
      return _toSession(response.data);
    });
  }

  Future<AuthUser> currentUser() {
    return _guard(() async {
      final response = await _gateway.client.getUsersApi().getCurrentUser();
      final user = response.data;
      if (user == null) throw const AuthFailure(AuthFailureKind.unexpected);
      return AuthUser.fromApi(user);
    });
  }

  AuthSessionData _toSession(AuthSession? session) {
    if (session == null) throw const AuthFailure(AuthFailureKind.unexpected);
    return AuthSessionData(
      token: session.accessToken,
      user: AuthUser.fromApi(session.user),
    );
  }

  Future<T> _guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on AuthFailure {
      rethrow;
    } on DioException catch (error) {
      throw _map(error);
    } catch (_) {
      throw const AuthFailure(AuthFailureKind.unexpected);
    }
  }

  AuthFailure _map(DioException error) {
    final status = error.response?.statusCode;
    switch (status) {
      case 400:
        return _validation(error.response?.data);
      case 401:
        return AuthFailure(
          error.requestOptions.headers.containsKey('Authorization')
              ? AuthFailureKind.unauthorized
              : AuthFailureKind.invalidCredentials,
        );
      case 409:
        return const AuthFailure(AuthFailureKind.emailTaken);
      case null:
        return AuthFailure(
          error.error is Exception || error.type != DioExceptionType.unknown
              ? AuthFailureKind.network
              : AuthFailureKind.unexpected,
        );
      default:
        return const AuthFailure(AuthFailureKind.unexpected);
    }
  }

  /// class-validator messages start with the property name ("email must be an
  /// email"), so the first word tells which field a message belongs to.
  AuthFailure _validation(Object? body) {
    const fields = {'name', 'email', 'password'};
    final raw = body is Map ? body['message'] : null;
    final messages = raw is List
        ? raw.map((m) => '$m').toList()
        : (raw is String ? [raw] : <String>[]);
    final byField = <String, String>{};
    final other = <String>[];
    for (final message in messages) {
      final field = message.split(' ').first;
      if (fields.contains(field)) {
        byField.putIfAbsent(field, () => message);
      } else {
        other.add(message);
      }
    }
    return AuthFailure(
      AuthFailureKind.validation,
      fieldErrors: byField,
      formErrors: other,
    );
  }
}
