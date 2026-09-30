import 'package:dio/dio.dart';

enum ApiFailureKind {
  /// `400`: see [ApiFailure.fieldErrors] and [ApiFailure.formErrors].
  validation,

  /// `401` on a secured call (the session expired; the gateway already signs out).
  unauthorized,

  /// `403`: the caller's role in the plan does not allow the action.
  forbidden,

  /// `404`: the plan or resource does not exist or is not visible.
  notFound,

  /// `409`: the resource is already in the requested state.
  conflict,

  /// The API could not be reached.
  network,

  /// Anything else (`5xx`, unexpected payload).
  unexpected,
}

/// Transport error of a plan-scoped call, mapped once so controllers only
/// decide what to show.
class ApiFailure implements Exception {
  const ApiFailure(
    this.kind, {
    this.fieldErrors = const {},
    this.formErrors = const [],
  });

  final ApiFailureKind kind;

  /// Validation messages by field name (first word of a class-validator
  /// message, e.g. `name`, `openingBalanceMinor`).
  final Map<String, String> fieldErrors;
  final List<String> formErrors;

  @override
  String toString() => 'ApiFailure($kind, $fieldErrors, $formErrors)';
}

/// Runs [call] and turns any transport error into an [ApiFailure].
Future<T> guardApi<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on ApiFailure {
    rethrow;
  } on DioException catch (error) {
    throw _map(error);
  } catch (_) {
    throw const ApiFailure(ApiFailureKind.unexpected);
  }
}

ApiFailure _map(DioException error) {
  switch (error.response?.statusCode) {
    case 400:
      return _validation(error.response?.data);
    case 401:
      return const ApiFailure(ApiFailureKind.unauthorized);
    case 403:
      return const ApiFailure(ApiFailureKind.forbidden);
    case 404:
      return const ApiFailure(ApiFailureKind.notFound);
    case 409:
      return const ApiFailure(ApiFailureKind.conflict);
    case null:
      return ApiFailure(
        error.error is Exception || error.type != DioExceptionType.unknown
            ? ApiFailureKind.network
            : ApiFailureKind.unexpected,
      );
    default:
      return const ApiFailure(ApiFailureKind.unexpected);
  }
}

ApiFailure _validation(Object? body) {
  final raw = body is Map ? body['message'] : null;
  final messages = raw is List
      ? raw.map((m) => '$m').toList()
      : (raw is String ? [raw] : <String>[]);
  final byField = <String, String>{};
  for (final message in messages) {
    // "firstAccount.name should not be empty" -> "firstAccount.name".
    byField.putIfAbsent(message.split(' ').first, () => message);
  }
  return ApiFailure(
    ApiFailureKind.validation,
    fieldErrors: byField,
    formErrors: messages,
  );
}
