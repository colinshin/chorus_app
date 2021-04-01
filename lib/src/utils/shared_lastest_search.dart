import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLatestSearch {
  static SharedPreferences _sharedPrefs;

  factory SharedPreferencesLatestSearch() =>
      SharedPreferencesLatestSearch._internal();

  SharedPreferencesLatestSearch._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  final _latestChorusSearch = 'LATEST_CHORUS_SEARCHED';
  final _latestHymnsSearch = 'LATEST_HYMNS_SEARCHED';
  final maxSize = 10;
  List<String> get latestChorusValue =>
      _sharedPrefs?.getStringList(_latestChorusSearch) ?? [];

  set latestChorusSearchs(String item) {
    final data = this.latestChorusValue;
    final index = data.indexWhere((e) => e.contains(item));

    if (index == -1) {
      if (data.length == maxSize) {
        data[0] = item;
        _sharedPrefs.setStringList(_latestChorusSearch, data);
        return;
      }
      data.add(item);
      _sharedPrefs.setStringList(_latestChorusSearch, data);

      return;
    }
    data.removeAt(index);
    _sharedPrefs.setStringList(_latestChorusSearch, data);
  }

  void clearChorusSearhAll() {
    _sharedPrefs?.setStringList(_latestChorusSearch, []);
  }

//HYM SEARCH

  List<String> get latestHymnsValue =>
      _sharedPrefs?.getStringList(_latestHymnsSearch) ?? [];

  set latestHymnsSearchs(String item) {
    final data = this.latestHymnsValue;
    final index = data.indexWhere((e) => e.contains(item));

    if (index == -1) {
      if (data.length == maxSize) {
        data[0] = item;
        _sharedPrefs.setStringList(_latestHymnsSearch, data);
        return;
      }
      data.add(item);
      _sharedPrefs.setStringList(_latestHymnsSearch, data);

      return;
    }
    data.removeAt(index);
    _sharedPrefs.setStringList(_latestHymnsSearch, data);
  }

  void clearHymnsSearhAll() {
    _sharedPrefs?.setStringList(_latestHymnsSearch, []);
  }
}
