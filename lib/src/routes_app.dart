import 'package:chorus_app/src/screens/about_screen.dart';
import 'package:chorus_app/src/screens/chorus_item_screen.dart';
import 'package:chorus_app/src/screens/chorus_screen.dart';
import 'package:chorus_app/src/screens/favorites_screen.dart';
import 'package:chorus_app/src/screens/home_screen.dart';
import 'package:chorus_app/src/screens/hymn_screen.dart';
import 'package:chorus_app/src/screens/hymns_item_screen.dart';
import 'package:chorus_app/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

getCurrentRouteApp({BuildContext ctx, @required String routeName}) {
  return routesApp()[routeName](ctx);
}

getRouteNameApp({BuildContext ctx, @required String routeName}) {
  String _key = '';
  routesApp().forEach((key, value) {
    if (routeName == key) {
      _key = key;
    }
  });
  return _key;
}

routesApp() {
  return {
    "homeScreen": (BuildContext ctx) => HomeScreen(),
    "splashScreen": (BuildContext ctx) => SplashScreen(
          ctx: ctx,
        ),
    "chorusLirycsScreen": (BuildContext ctx) => ChorusLirycsScreen(),
    'aboutScreen': (BuildContext ctx) => AboutScreen(),
    "hymnScreenLirycsScreen": (BuildContext ctx) => HymnLirycsScreen(),
  };
}
