import 'package:chorus_app/src/utils/shared_lastest_search.dart';
import 'package:flutter/material.dart';

class LastSearchProvider extends ChangeNotifier {
  SharedPreferencesLatestSearch shared;

  static final LastSearchProvider _instance = LastSearchProvider.__internal();
  LastSearchProvider.__internal();
  factory LastSearchProvider({@required SharedPreferencesLatestSearch share}) {
    _instance.shared = share;
    return _instance;
  }

  List<String> _chorusSearched = [];
  List<String> _hymnsSearched = [];

  List<String> get lastSearchChorus {
    return shared.latestChorusValue;
  }

  List<String> get chorusSearched {
    _chorusSearched = lastSearchChorus;
    return this._chorusSearched;
  }

  set lastSearchProvider(String lastSearch) {
    shared.latestChorusSearchs = lastSearch;
    notifyListeners();
  }

  void removeAllChorusSearched() {
    shared.clearChorusSearhAll();
    _chorusSearched = [];
    notifyListeners();
  }

  List<String> get lastSearchHymns {
    return shared.latestHymnsValue;
  }

  List<String> get hymnSearched {
    _hymnsSearched = lastSearchHymns;
    return this._hymnsSearched;
  }

  set lastSearchHymnProvider(String lastSearch) {
    shared.latestHymnsSearchs = lastSearch;
    notifyListeners();
  }

  void removeAllHymnSearched() {
    shared.clearHymnsSearhAll();
    _hymnsSearched = [];
    notifyListeners();
  }
}
