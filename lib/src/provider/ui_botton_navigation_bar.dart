import 'package:flutter/material.dart';

class UiBottonNavigationBar extends ChangeNotifier {
  static final UiBottonNavigationBar _instance = UiBottonNavigationBar._init();
  UiBottonNavigationBar._init();
  factory UiBottonNavigationBar() => _instance;
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    // notifyListeners();
  }
}
