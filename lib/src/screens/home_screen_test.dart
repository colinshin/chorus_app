import 'package:chorus_app/src/delegates/search_chorus_delegate.dart';
import 'package:chorus_app/src/delegates/search_delegate_hymns.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/screens/chorus_screen.dart';

import 'package:chorus_app/src/screens/favorites_screen.dart';
import 'package:chorus_app/src/screens/hymn_screen.dart';
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
      appBar: getAppBarIndex(context),
      body: _HomeScreenBody(),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }

  AppBar getAppBarIndex(BuildContext ctx) {
    final uiAppProvider = Provider.of<UiBottonNavigationBar>(ctx);
    final _prov = Provider.of<ChorusJsonProvider>(ctx);
    switch (uiAppProvider.selectedMenuOpt) {
      case 0:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _handleSearchCoros(ctx, _prov))
        ], ctx: ctx, title: "Coros pentecostales");
      case 1:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _handleSearchHymns(ctx, _prov))
        ], ctx: ctx, title: "Lluvia de bendiciones");
      case 2:
        return getAppBar(actions: [
          IconButton(icon: Icon(Icons.search), onPressed: _handleSearchFavorite)
        ], ctx: ctx, title: "Mis favoritos");
      case 3:
        return getAppBar(
          ctx: ctx,
          title: "Mis ajustes",
        );
      default:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _handleSearchCoros(ctx, _prov))
        ], ctx: ctx, title: "Coros pentecostales");
    }
  }

  AppBar getAppBar({BuildContext ctx, String title, List<Widget> actions}) {
    if (actions == null || actions.length > 0) {
      return AppBar(
        actions: actions,
        title: Text(
          title,
        ),
      );
    }
    return AppBar(
      title: Text(
        title,
      ),
    );
  }

  void _handleSearchCoros(BuildContext ctx, ChorusJsonProvider _prov) {
    showSearch(context: ctx, delegate: ChorusSearchScreen(songs: _prov.chorus));
  }

  void _handleSearchHymns(BuildContext ctx, ChorusJsonProvider _prov) {
    showSearch(context: ctx, delegate: HymnSearchDelegate(hymns: _prov.hymns));
  }

  void _handleSearchFavorite() {}
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

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [],
      title: Text("hello"),
    );
  }
}
