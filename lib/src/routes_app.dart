import 'package:chorus_app/src/screens/chorus_item_screen.dart';
import 'package:chorus_app/src/screens/chorus_screen.dart';
import 'package:chorus_app/src/screens/favorites_screen.dart';
import 'package:chorus_app/src/screens/home_screen_test.dart';
import 'package:chorus_app/src/screens/hymn_screen_sec.dart';
import 'package:chorus_app/src/screens/hymns_item_screen.dart';
import 'package:chorus_app/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

routesApp() {
  return {
    "chorusScreen": (BuildContext ctx) => ChorusScreen(),
    "homeScreen": (BuildContext ctx) => HomeScreen(),
    "hymnScreen": (BuildContext ctx) => HymnScreen(),
    "splashScreen": (BuildContext ctx) => SplashScreen(),
    "chorusLirycsScreen": (BuildContext ctx) => ChorusLirycsScreen(),
    "favoriteScreen": (BuildContext ctx) => FavoritesScreen(),
    "hymnScreenLirycsScreen": (BuildContext ctx) => HymnLirycsScreen(),
  };
}
