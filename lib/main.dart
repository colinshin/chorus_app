import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/routes_app.dart';
import 'package:chorus_app/src/settings/theme_app.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new SharedPreferencesUtil();
  await prefs.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _prefs = new SharedPreferencesUtil();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => new FavoriteChorusAppProvider()),
      ChangeNotifierProvider(
          create: (BuildContext ctx) => ChorusJsonProvider()),
      ChangeNotifierProvider(
          create: (BuildContext ctx) => new UiBottonNavigationBar()),
      ChangeNotifierProvider(
          create: (BuildContext ctx) => new UiSharedPreferencesProvider(
              _prefs.darkTheme, _prefs.fontSize))
    ], child: MaterialAppTheme());
  }
}

class MaterialAppTheme extends StatefulWidget {
  @override
  _MaterialAppThemeState createState() => _MaterialAppThemeState();
}

class _MaterialAppThemeState extends State<MaterialAppTheme> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _provFavorite = Provider.of<FavoriteChorusAppProvider>(context);
    if (!_loading) {
      _provFavorite.getChorus();
      setState(() {
        _loading = true;
      });
    }
    _getThemeBool(context)
        ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light)
        : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      routes: routesApp(),
      themeMode: _getThemeBool(context) ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: 'splashScreen',
      theme: _getThemeBool(context)
          ? getThemeDarkApp(context)
          : getLightThemeApp(context),
    );
  }

  bool _getThemeBool(BuildContext context) {
    final _prefs = new SharedPreferencesUtil();
    final _prov = Provider.of<UiSharedPreferencesProvider>(context);
    final _provFav = Provider.of<FavoriteChorusAppProvider>(context);
    _provFav.getChorus();
    _prov.darkTheme = _prefs.darkTheme;

    return _prov.darkTheme;
  }
}
