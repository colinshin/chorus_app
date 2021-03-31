import 'package:flutter/material.dart';

class UiKeepDataSearched extends ChangeNotifier {
  String _searchChorus;
  String _searchHymn;
  String _searchFavorite;

  String get searchChorus {
    return this._searchChorus;
  }

  String get searchHymn {
    return this._searchHymn;
  }

  String get searchFavorite {
    return this._searchFavorite;
  }

  set searchChorus(String str) {
    this._searchChorus = str;
   // notifyListeners();
  }

  set searchHymn(String str) {
    this._searchHymn = str;
   // notifyListeners();
  }

  set searchFavorite(String str) {
    this._searchFavorite = str;
   // notifyListeners();
  }
}
