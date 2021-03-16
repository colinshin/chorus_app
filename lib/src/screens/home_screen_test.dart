import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/screens/chorus_screen.dart';

import 'package:chorus_app/src/screens/favorites_screen.dart';
import 'package:chorus_app/src/screens/hymn_screen_sec.dart';
import 'package:chorus_app/src/screens/settings_screen.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:chorus_app/src/widgets/botton_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeScreenBody(),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}

class _HomeScreenBody extends StatefulWidget {
  @override
  __HomeScreenBodyState createState() => __HomeScreenBodyState();
}

class __HomeScreenBodyState extends State<_HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    final uiTabProvider = Provider.of<UiBottonNavigationBar>(context);
    final provTheme = Provider.of<UiSharedPreferencesProvider>(context);
    final sharedPref = new SharedPreferencesUtil();

    if (!_loading) {
      provTheme.darkTheme = sharedPref.darkTheme;
      _loading = true;

      setState(() {});
    }
    switch (uiTabProvider.selectedMenuOpt) {
      case 0:
        return ChorusScreen();
      case 1:
        return HymnScreen();
      case 2:
        return FavoritesScreen();
      case 3:
        return SettingsScreen();
      default:
        return ChorusScreen();
    }
  }
}
