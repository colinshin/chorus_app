import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _prefs = new SharedPreferencesUtil();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<UiSharedPreferencesProvider>(context);
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Establece Tus Normas",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Tema oscuro"),
                Switch(
                  activeTrackColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool value) {
                    _prefs.darkTheme = value;
                    themeProvider.darkTheme = value;
                    setState(() {});
                  },
                  value: _prefs.darkTheme,
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Tamaño de la fuente"),
                SizedBox(
                  height: 20.0,
                ),
                Slider(
                    value: _prefs.fontSize,
                    max: 40,
                    min: 15,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).accentColor,
                    onChanged: (val) {
                      _prefs.fontSize = val;
                      themeProvider.fontSize = val;
                      setState(() {});
                    }),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Jesús",
                  style: TextStyle(fontSize: _prefs.fontSize),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
