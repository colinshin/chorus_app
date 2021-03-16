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
  final _lastPageKey = 'last_page';

  get fontSize => _sharedPrefs.getDouble(_fontSize) ?? 15.0;
  set fontSize(double val) => _sharedPrefs.setDouble(_fontSize, val);

  get darkTheme => _sharedPrefs.getBool(_themeDark) ?? false;
  set darkTheme(bool val) => _sharedPrefs.setBool(_themeDark, val);

  get lastPage => _sharedPrefs.getString(_lastPageKey) ?? 'homeScreen';
  set lastPage(String val) => _sharedPrefs.setString(_lastPageKey, val);
}