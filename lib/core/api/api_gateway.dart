import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

/// Owns the generated [ApiClient]: one Dio instance with the bearer token
/// attached to every secured call and a hook for `401` responses.
///
/// Features read the typed APIs from [client] (`getAuthApi()`, ...); nothing
/// else in the app builds a Dio.
class ApiGateway {
  ApiGateway({required String baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    client = ApiClient(
      dio: dio,
      interceptors: [_bearer, _UnauthorizedInterceptor(this)],
    );
  }

  static const String _schemeName = 'bearerAuth';

  final BearerAuthInterceptor _bearer = BearerAuthInterceptor();
  late final ApiClient client;

  /// Called when a secured request is rejected with `401`, i.e. the stored
  /// token is invalid or expired. Set by the session owner (`AuthController`).
  void Function()? onUnauthorized;

  /// Sets (or clears, with `null`) the bearer token sent with secured calls.
  void setToken(String? token) {
    if (token == null) {
      _bearer.tokens.remove(_schemeName);
    } else {
      _bearer.tokens[_schemeName] = token;
    }
  }

  bool get hasToken => _bearer.tokens.containsKey(_schemeName);
}

class _UnauthorizedInterceptor extends Interceptor {
  _UnauthorizedInterceptor(this._gateway);

  final ApiGateway _gateway;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final sentToken = err.requestOptions.headers.containsKey('Authorization');
    if (err.response?.statusCode == 401 && sentToken) {
      _gateway.onUnauthorized?.call();
    }
    handler.next(err);
  }
}
