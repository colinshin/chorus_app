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
  final _lastIndexKey = 'LAST_INDEX_KEY';
  final _lastFavoriteKey = 'LAST_FAVORITE_KEY';
  final _lastPageKey = 'LAST_PAGE_KEY';
  final _lastIdSongKey = 'LAST_ID_SONG_KEY';

  get fontSize => _sharedPrefs.getDouble(_fontSize) ?? 15.0;
  set fontSize(double val) => _sharedPrefs.setDouble(_fontSize, val);

  get darkTheme => _sharedPrefs.getBool(_themeDark) ?? false;
  set darkTheme(bool val) => _sharedPrefs.setBool(_themeDark, val);

  int get lastPageIndex => _sharedPrefs.getInt(_lastIndexKey) ?? 0;
  set lastPageIndex(int val) => _sharedPrefs.setInt(_lastIndexKey, val);

  int get lastFavoritePageIndex => _sharedPrefs.getInt(_lastFavoriteKey) ?? 0;
  set lastFavoritePageIndex(int val) =>
      _sharedPrefs.setInt(_lastFavoriteKey, val);

  String get lastPage => _sharedPrefs.getString(_lastPageKey) ?? 'homeScreen';
  set lastPage(String val) => _sharedPrefs.setString(_lastPageKey, val);

  int get lastIdSong => _sharedPrefs.getInt(_lastIdSongKey) ?? 0;
  set lastIdSong(int val) => _sharedPrefs.setInt(_lastIdSongKey, val);
}
