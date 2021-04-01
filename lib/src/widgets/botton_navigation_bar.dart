import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiTabProvider = Provider.of<UiBottonNavigationBar>(context);
    final _uiShared = Provider.of<UiSharedPreferencesProvider>(context);
    final _pref = SharedPreferencesUtil();

    Color btNavigationcolor = _uiShared.darkTheme ? Colors.black : Colors.white;
    return CurvedNavigationBar(
        index: uiTabProvider.selectedMenuOpt,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.fastLinearToSlowEaseIn,
        backgroundColor: _uiShared.darkTheme
            ? Colors.black12
            : Theme.of(context).primaryColor,
        color:
            _uiShared.darkTheme ? Theme.of(context).primaryColor : Colors.black,
        height: 55.0,
        items: <Widget>[
          Icon(Icons.queue_music_rounded, color: btNavigationcolor, size: 30),
          Icon(Icons.library_music, color: btNavigationcolor, size: 30),
          Icon(Icons.favorite, color: btNavigationcolor, size: 30),
          Icon(Icons.settings, color: btNavigationcolor, size: 30)
        ],
        onTap: (int opt) => onTaped(uiTabProvider, opt, _pref));
  }

  void onTaped(UiBottonNavigationBar providerTab, int option,
      SharedPreferencesUtil _pref) {
    _pref.lastPageIndex = option;
    providerTab.selectedMenuOpt = option;
  }
}
