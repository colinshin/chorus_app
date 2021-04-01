import 'package:flutter/material.dart';

class FavoriteUiProvider extends ChangeNotifier {
  int _tab = 0;

  int get tab {
    return this._tab;
  }

  String get tabName {
    return this._tab == 0 ? 'chorus' : 'hymn';
  }

  String get tabLabel {
    return this._tab == 0 ? 'Coros' : 'Himnos';
  }

  set tab(int tab) {
    this._tab = tab;
  }
}
