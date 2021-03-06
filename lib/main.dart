import 'dart:async';

import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_ui_provider.dart';
import 'package:chorus_app/src/provider/last_search_provider.dart';
import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/provider/ui_scroll_list_view.dart';
import 'package:chorus_app/src/provider/ui_search_keep_data.dart';
import 'package:chorus_app/src/routes_app.dart';
import 'package:chorus_app/src/settings/theme_app.dart';
import 'package:chorus_app/src/utils/shared_lastest_search.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: non_constant_identifier_names
  final __ = new SharedPreferencesUtil();
  final _ = SharedPreferencesLatestSearch();
  await _.init();
  await __.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runZonedGuarded(() {
      runApp(new MyApp());
    }, (dynamic error, dynamic stack) {
      print(error);
      print(stack);
    });
  });
}

class MyApp extends StatelessWidget {
  final _prefs = new SharedPreferencesUtil();
  @override
  Widget build(BuildContext context) {
    final lastSearch = SharedPreferencesLatestSearch();
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => new LastSearchProvider(share: lastSearch)),
      ChangeNotifierProvider(create: (_) => new UiKeepScroll()),
      ChangeNotifierProvider(create: (_) => new UiKeepDataSearched()),
      ChangeNotifierProvider(create: (_) => new FavoriteChorusAppProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteUiProvider.instance),
      ChangeNotifierProvider(
          create: (BuildContext ctx) => ChorusJsonProvider()),
      ChangeNotifierProvider(
          create: (BuildContext ctx) => new UiBottonNavigationBar()),
      ChangeNotifierProvider(
          create: (BuildContext ctx) => new UiSharedPreferencesProvider(
              dark: _prefs.darkTheme, size: _prefs.fontSize))
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
