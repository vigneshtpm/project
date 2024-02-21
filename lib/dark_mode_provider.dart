import 'package:flutter/material.dart';

class DarkModeProvider with ChangeNotifier {
  bool _darkModeEnabled = false;

  bool get darkModeEnabled => _darkModeEnabled;

  set darkModeEnabled(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
  }
}
