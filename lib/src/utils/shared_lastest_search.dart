import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLatestSearch {
  static SharedPreferences _sharedPrefs;

  factory SharedPreferencesLatestSearch() =>
      SharedPreferencesLatestSearch._internal();

  SharedPreferencesLatestSearch._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  List<String> latestChorusSearch({String prefKey}) =>
      _sharedPrefs?.getStringList(prefKey) ?? [];

  void latestChorusSearchs({String item, String prefKey}) {
    final data = this.latestChorusSearch(prefKey: prefKey);

    final index = data.indexWhere((e) => e.contains(item));

    if (index == -1) {
      if (data.length == 10) {
        data[0] = item;
        _sharedPrefs.setStringList(prefKey, data);
      }
      return;
    }
    data.removeRange(index, 1);
    _sharedPrefs.setStringList(prefKey, data);
  }

  void clearChorusSearhAll({String prefKey}) {
    _sharedPrefs?.setStringList(prefKey, []);
  }
}

class SharedPrefConstant {
  static final latestChorusSearch = 'LATEST_CHORUS_SEARCHED';
  static final latestHymnSearch = 'LATEST_HYMN_SEARCHED';
}
