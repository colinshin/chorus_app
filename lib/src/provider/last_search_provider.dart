import 'package:chorus_app/src/utils/shared_lastest_search.dart';
import 'package:flutter/material.dart';

class LastSearchProvider extends ChangeNotifier {
  final SharedPreferencesLatestSearch shared;
  LastSearchProvider({@required this.shared});

  List<String> _lastChorusSearch = [];
  List<String> _lastHymnsSearch = [];

  List<String> get lastSearchChorus {
    _lastChorusSearch = shared.latestChorusSearch(
        prefKey: SharedPrefConstant.latestChorusSearch);

    return this._lastChorusSearch;
  }

  set lastSearchProvider(String lastSearch) {
    shared.latestChorusSearchs(
        item: lastSearch, prefKey: SharedPrefConstant.latestChorusSearch);
    notifyListeners();
  }

  void removeAllChorusSearched() {
    shared.clearChorusSearhAll(prefKey: SharedPrefConstant.latestChorusSearch);
    _lastChorusSearch = [];
    notifyListeners();
  }
}
