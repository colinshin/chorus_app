import 'package:flutter/material.dart';

class FavoriteUiProvider extends ChangeNotifier {
  FavoriteUiProvider._internal();

  static final FavoriteUiProvider _instance = FavoriteUiProvider._internal();

  static FavoriteUiProvider get instance => _instance;

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
