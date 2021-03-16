import 'package:flutter/material.dart';

class UiSharedPreferencesProvider extends ChangeNotifier {
  bool _darkTheme = false;
  double _fontSize = 15.0;

  UiSharedPreferencesProvider(bool _darkTheme, double _fontSize);

  bool get darkTheme {
    return this._darkTheme;
  }

  set darkTheme(bool theme) {
    this._darkTheme = theme;
    notifyListeners();
  }

  double get fontSize {
    return this._fontSize;
  }

  set fontSize(double size) {
    this._fontSize = size;
    notifyListeners();
  }
}
