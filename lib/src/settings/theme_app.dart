import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

ThemeData getLightThemeApp(BuildContext ctx) {
  final _prefs = new SharedPreferencesUtil();
  return ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.teal,
      snackBarTheme: SnackBarThemeData(elevation: 5.0),
      scaffoldBackgroundColor: Colors.white70,
      brightness: Brightness.light,
      primaryTextTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 24.0,
            fontFamily: "Lobster Regular",
            fontWeight: FontWeight.bold,
            wordSpacing: 0.4,
            color: Colors.black),
        headline6: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.black),
        headline2: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.black),
        headline3: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.black),
        headline4: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.black),
        headline5: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.black),
        bodyText1: TextStyle(
          fontSize: _prefs.fontSize,
          fontFamily: "ABeeZee Regular",
          fontWeight: FontWeight.normal,
        ),
        bodyText2: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.black),
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 24.0,
              fontFamily: "Lobster Regular",
              fontWeight: FontWeight.bold,
              wordSpacing: 0.4,
              color: Colors.black),
          headline2: TextStyle(
              fontSize: 24.0,
              fontFamily: "Lobster Regular",
              fontWeight: FontWeight.bold,
              wordSpacing: 0.4,
              color: Colors.black),
          headline3: TextStyle(
              fontSize: 24.0,
              fontFamily: "Lobster Regular",
              fontWeight: FontWeight.bold,
              wordSpacing: 0.4,
              color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 20.0,
              fontFamily: "Lobster Regular",
              wordSpacing: 0.2,
              color: Colors.black),
          bodyText1: TextStyle(
            fontSize: _prefs.fontSize,
            fontFamily: "ABeeZee Regular",
            fontWeight: FontWeight.normal,
          )));
}

ThemeData getThemeDarkApp(BuildContext ctx) {
  final _prefs = new SharedPreferencesUtil();
  return ThemeData(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.white70,
      snackBarTheme: SnackBarThemeData(elevation: 5.0),
      scaffoldBackgroundColor: Colors.black,
      elevatedButtonTheme: ElevatedButtonTheme.of(ctx),
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 2.0,
      ),
      primaryTextTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 24.0,
            fontFamily: "Lobster Regular",
            fontWeight: FontWeight.bold,
            wordSpacing: 0.4,
            color: Colors.white),
        headline6: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.white),
        headline2: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.white),
        headline3: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.white),
        headline4: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.white),
        headline5: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.white),
        bodyText1: TextStyle(
          fontSize: _prefs.fontSize,
          fontFamily: "ABeeZee Regular",
          fontWeight: FontWeight.normal,
        ),
        bodyText2: TextStyle(
            fontSize: 20.0,
            fontFamily: "Lobster Regular",
            wordSpacing: 0.2,
            color: Colors.white),
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 24.0,
              fontFamily: "Lobster Regular",
              fontWeight: FontWeight.bold,
              wordSpacing: 0.4,
              color: Colors.white),
          headline2: TextStyle(
              fontSize: 24.0,
              fontFamily: "Lobster Regular",
              fontWeight: FontWeight.bold,
              wordSpacing: 0.4,
              color: Colors.black),
          headline3: TextStyle(
              fontSize: 24.0,
              fontFamily: "Lobster Regular",
              fontWeight: FontWeight.bold,
              wordSpacing: 0.4,
              color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 20.0,
              fontFamily: "Lobster Regular",
              wordSpacing: 0.2,
              color: Colors.white),
          bodyText1: TextStyle(
            fontSize: _prefs.fontSize,
            fontFamily: "ABeeZee Regular",
            fontWeight: FontWeight.normal,
          )));
}
