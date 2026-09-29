import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the access token lives between app launches.
abstract interface class SessionStorage {
  Future<String?> readToken();
  Future<void> writeToken(String token);
  Future<void> deleteToken();
}

/// Platform secure storage (Android Keystore / iOS Keychain).
class SecureSessionStorage implements SessionStorage {
  const SecureSessionStorage([this._storage = const FlutterSecureStorage()]);

  static const String _key = 'access_token';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readToken() async {
    try {
      return await _storage.read(key: _key);
    } catch (_) {
      // Unreadable storage (e.g. keystore reset after restore): behave as signed out.
      return null;
    }
  }

  @override
  Future<void> writeToken(String token) =>
      _storage.write(key: _key, value: token);

  @override
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _key);
    } catch (_) {
      // Nothing to delete or storage unavailable; the in-memory session is cleared anyway.
    }
  }
}
