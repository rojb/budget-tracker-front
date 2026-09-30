import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Remembers which plan was active between app launches (the API has no
/// notion of a "current" plan).
abstract interface class ActivePlanStorage {
  Future<String?> read();
  Future<void> write(String planId);
  Future<void> clear();
}

class SecureActivePlanStorage implements ActivePlanStorage {
  const SecureActivePlanStorage([this._storage = const FlutterSecureStorage()]);

  static const String _key = 'active_plan_id';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() async {
    try {
      return await _storage.read(key: _key);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(String planId) async {
    try {
      await _storage.write(key: _key, value: planId);
    } catch (_) {
      // Not remembering the plan only means opening the first one next time.
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: _key);
    } catch (_) {}
  }
}
