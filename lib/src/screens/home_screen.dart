import 'package:chorus_app/src/delegates/search_chorus_delegate.dart';
import 'package:chorus_app/src/delegates/search_delegate_hymns.dart';
import 'package:chorus_app/src/delegates/search_favorite_chorus_delegate.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_ui_provider.dart';
import 'package:chorus_app/src/provider/last_search_provider.dart';
import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/provider/ui_botton_navigation_bar.dart';
import 'package:chorus_app/src/provider/ui_search_keep_data.dart';
import 'package:chorus_app/src/screens/chorus_screen.dart';

import 'package:chorus_app/src/screens/favorites_screen.dart';
import 'package:chorus_app/src/screens/hymn_screen.dart';
import 'package:chorus_app/src/screens/settings_screen.dart';
import 'package:chorus_app/src/utils/shared_lastest_search.dart';
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
    final _provFavorites = Provider.of<FavoriteChorusAppProvider>(ctx);
    final _provFavoriteUi = Provider.of<FavoriteUiProvider>(ctx);
    final _provSearch = Provider.of<UiKeepDataSearched>(ctx);
    final _recentSearch = Provider.of<LastSearchProvider>(ctx);
    switch (uiAppProvider.selectedMenuOpt) {
      case 0:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  _handleSearchCoros(ctx, _prov, _provSearch, _recentSearch))
        ], ctx: ctx, title: "Coros pentecostales");
      case 1:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _handleSearchHymns(ctx, _prov, _provSearch))
        ], ctx: ctx, title: "Lluvia de bendiciones");
      case 2:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _handleSearchFavorite(
                  ctx, _provFavorites, _provFavoriteUi, _provSearch))
        ], ctx: ctx, paintAppbar: true);
      case 3:
        return getAppBar(
          ctx: ctx,
          title: "Mis ajustes",
        );
      default:
        return getAppBar(actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  _handleSearchCoros(ctx, _prov, _provSearch, _recentSearch))
        ], ctx: ctx, title: "Coros pentecostales");
    }
  }

  AppBar getAppBar(
      {BuildContext ctx,
      String title = "",
      List<Widget> actions,
      bool paintAppbar = false}) {
    if (paintAppbar) {
      final _favProvider = Provider.of<FavoriteUiProvider>(ctx);
      return AppBar(
        actions: actions,
        title: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.queue_music_rounded,
                      color:
                          _favProvider.tab == 0 ? Colors.white : Colors.black,
                      size: 30),
                  onPressed: () {
                    _favProvider.tab = 0;
                  },
                ),
                Text(
                  _favProvider.tabLabel,
                  style: Theme.of(ctx).textTheme.headline2,
                ),
                IconButton(
                  icon: Icon(Icons.library_music,
                      color:
                          _favProvider.tab == 1 ? Colors.white : Colors.black,
                      size: 30),
                  onPressed: () {
                    _favProvider.tab = 1;
                  },
                )
              ],
            )),
      );
    }

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

  void _handleSearchCoros(BuildContext ctx, ChorusJsonProvider _prov,
      UiKeepDataSearched _provSearch, LastSearchProvider recentSearch) {
    showSearch(
        context: ctx,
        query: _provSearch?.searchChorus ?? '',
        delegate: ChorusSearchScreen(
          songs: _prov.chorus,
          provSearch: _provSearch,
          recentSearched: recentSearch,
        ));
  }

  void _handleSearchHymns(BuildContext ctx, ChorusJsonProvider _prov,
      UiKeepDataSearched _provSearch) {
    showSearch(
        context: ctx,
        query: _provSearch?.searchHymn ?? '',
        delegate:
            HymnSearchDelegate(hymns: _prov.hymns, provSearch: _provSearch));
  }

  _handleSearchFavorite(
      BuildContext ctx,
      FavoriteChorusAppProvider provFavorites,
      FavoriteUiProvider provFavoriteUi,
      UiKeepDataSearched _provSearch) {
    showSearch(
        context: ctx,
        query: _provSearch?.searchFavorite ?? '',
        delegate: FavoriteChorusSearch(
            label: provFavoriteUi.tabLabel,
            choruses: provFavorites,
            provSearch: _provSearch,
            type: provFavoriteUi.tabName));
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
