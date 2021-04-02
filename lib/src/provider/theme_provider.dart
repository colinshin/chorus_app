import 'package:flutter/material.dart';

class UiSharedPreferencesProvider extends ChangeNotifier {
  static final UiSharedPreferencesProvider _instance =
      UiSharedPreferencesProvider.__internal();
  UiSharedPreferencesProvider.__internal();
  factory UiSharedPreferencesProvider(
      {@required bool dark, @required double size}) {
    _instance._darkTheme = dark;
    _instance._fontSize = size;
    return _instance;
  }

  bool _darkTheme = false;
  double _fontSize = 15.0;

  bool get darkTheme {
    return this._darkTheme;
  }

  set darkTheme(bool theme) {
    this._darkTheme = theme;
  }

  double get fontSize {
    return this._fontSize;
  }

  set fontSize(double size) {
    this._fontSize = size;
    notifyListeners();
  }
}
