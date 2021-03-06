import 'dart:async';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_ui_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/routes_app.dart';
import 'package:chorus_app/src/screens/home_screen.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final BuildContext ctx;
  SplashScreen({@required this.ctx});
  @override
  _SplashScreenState createState() => _SplashScreenState(ctx: this.ctx);
}

class _SplashScreenState extends State<SplashScreen> {
  final BuildContext ctx;
  _SplashScreenState({@required this.ctx});
  final splashDelay = 3;
  bool _call = false;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    final _prov = Provider.of<UiBottonNavigationBar>(ctx, listen: false);
    final _favProvider = Provider.of<FavoriteUiProvider>(ctx, listen: false);
    final _pref = SharedPreferencesUtil();

    _prov.selectedMenuOpt = _pref.lastPageIndex;
    _favProvider.tab = _pref.lastFavoritePageIndex;

    final route = getCurrentRouteApp(routeName: _pref.lastPage, ctx: ctx);
    final routeName = getRouteNameApp(routeName: _pref.lastPage, ctx: ctx);

    if (route is HomeScreen) {
      Navigator.of(ctx).pushReplacementNamed(routeName);
      return;
    }

    Navigator.pushReplacementNamed(ctx, routeName,
        arguments: {'id': _pref.lastIdSong, 'where':'splash'});
  }

  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<ChorusJsonProvider>(context);
    final provFavorites = Provider.of<FavoriteChorusAppProvider>(context);
    final TextStyle textWhite = TextStyle(color: Colors.white);
    if (!_call) {
      _getFavorites(provFavorites);
      _getChorus(_prov);

      setState(() {
        _call = true;
      });
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'assets/img/loading.gif',
                    height: 320,
                    width: 320,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Worship App",
                        style: textWhite,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Developed By ',
                        style: textWhite,
                      ),
                      Text(
                        "C??sar",
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  '${DateTime.now().day.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().year.toString()} ${DateTime.now().hour.toString()} : ${DateTime.now().minute.toString()}',
                  style: textWhite,
                )
              ],
            )
          ],
        ));
  }

  _getChorus(ChorusJsonProvider prov) {
    prov.getChorus();
    prov.getHymns();
  }

  _getFavorites(FavoriteChorusAppProvider provFavorites) {
    provFavorites.getChorus();
  }
}
