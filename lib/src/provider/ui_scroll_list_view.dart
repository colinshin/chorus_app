import 'package:flutter/material.dart';

class UiKeepScroll extends ChangeNotifier {
  double _scrollHymn = 0.0;
  double _scrollChorus = 0.0;

  double get scrollChorus {
    return this._scrollChorus;
  }

  double get scrollHymn {
    return this._scrollHymn;
  }

  set scrollChorus(double str) {
    this._scrollChorus = str;
  }

  set scrollHymn(double sc) {
    this._scrollHymn = sc;
    notifyListeners();
  }
}
