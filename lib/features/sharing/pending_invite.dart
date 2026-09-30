/// Invitation code from a `sobres.app/unirse/<code>` link opened without a
/// session: kept while the person signs up or in, then 45 consumes it.
class PendingInvite {
  String? _code;

  String? get code => _code;

  void remember(String code) => _code = code;

  void clear() => _code = null;
}
