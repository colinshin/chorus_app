import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences _sharedPrefs;

  factory SharedPreferencesUtil() => SharedPreferencesUtil._internal();

  SharedPreferencesUtil._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  final _fontSize = 'FONT_SIZE';
  final _themeDark = 'THEME';
  final _lastPageKey = 'LAST_PAGE';

  get fontSize => _sharedPrefs.getDouble(_fontSize) ?? 15.0;
  set fontSize(double val) => _sharedPrefs.setDouble(_fontSize, val);

  get darkTheme => _sharedPrefs.getBool(_themeDark) ?? false;
  set darkTheme(bool val) => _sharedPrefs.setBool(_themeDark, val);

  int get lastPageIndex => _sharedPrefs.getInt(_lastPageKey) ?? 0;
  set lastPageIndex(int val) => _sharedPrefs.setInt(_lastPageKey, val);
}
