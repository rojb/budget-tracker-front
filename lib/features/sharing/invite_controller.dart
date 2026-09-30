import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/api/api_failure.dart';
import 'sharing_repository.dart';

/// State of 21 Invitar miembro for one plan.
class InviteController extends ChangeNotifier {
  InviteController(this._repository, this.planId);

  final SharingRepository _repository;
  final String planId;

  InvitationData? _invitation;
  InviteRole _role = InviteRole.editor;
  bool _busy = false;
  bool _copied = false;
  ApiFailure? _failure;
  Timer? _copiedTimer;
  bool _disposed = false;

  InvitationData? get invitation => _invitation;
  InviteRole get role => _role;
  bool get busy => _busy;
  bool get copied => _copied;
  ApiFailure? get failure => _failure;

  /// Shows the active code, or creates an editor code when there is none.
  Future<void> load() => _run(() async {
    _invitation = await _repository.activeInvitation(planId);
    _invitation ??= await _repository.createInvitation(planId, _role);
    _role = _invitation!.role;
  });

  /// Choosing another role generates a code with that role.
  Future<void> selectRole(InviteRole role) async {
    if (role == _role && _invitation != null) return;
    _role = role;
    await regenerate();
  }

  Future<void> regenerate() => _run(() async {
    _invitation = await _repository.createInvitation(planId, _role);
  });

  Future<void> revoke() => _run(() async {
    await _repository.revokeInvitation(planId);
    _invitation = null;
  });

  /// The page copies to the clipboard; this shows "Copiado" for ~1.5 s.
  void markCopied() {
    _copied = true;
    notifyListeners();
    _copiedTimer?.cancel();
    _copiedTimer = Timer(const Duration(milliseconds: 1500), () {
      _copied = false;
      notifyListeners();
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    _busy = true;
    _failure = null;
    notifyListeners();
    try {
      await action();
    } on ApiFailure catch (failure) {
      _failure = failure;
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _copiedTimer?.cancel();
    super.dispose();
  }
}
