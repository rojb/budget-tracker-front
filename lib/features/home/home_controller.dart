import 'package:flutter/foundation.dart';

/// UI state for the home screen. Later changes load real data through the
/// API client injected from the composition root.
class HomeController extends ChangeNotifier {
  String _message = 'Budget Tracker scaffold';

  String get message => _message;

  void updateMessage(String value) {
    if (value == _message) return;
    _message = value;
    notifyListeners();
  }
}
