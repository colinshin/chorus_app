import 'dart:math';

import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/last_search_provider.dart';
import 'package:chorus_app/src/provider/ui_search_keep_data.dart';
import 'package:chorus_app/src/widgets/chorus_item_widget.dart';
import 'package:chorus_app/src/widgets/empty_state_widget.dart';
import 'package:chorus_app/src/widgets/item_searched.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:provider/provider.dart';

class ChorusSearchScreen extends SearchDelegate<String> {
  final List<Song> songs;
  final LastSearchProvider recentSearched;
  final DateTime date = DateTime.now();
  final UiKeepDataSearched provSearch;
  ChorusSearchScreen(
      {@required this.songs,
      @required this.provSearch,
      @required this.recentSearched});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_sharp),
          onPressed: () {
            query = '';
            provSearch.searchChorus = query;
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, null);
    return Container();
  }

  @override
  void close(BuildContext context, result) {
    super.close(context, result);
    if (query.length >= 3) {
      recentSearched.lastSearchProvider = query;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Song> suggest = [];

    if (recentSearched.lastSearchChorus.length != 0 && query.length == 0) {
      return ListView.builder(
        itemCount: recentSearched.lastSearchChorus.length,
        itemBuilder: (context, index) {
          return Column(children: [
            index == 0
                ? deleteAllSearched(handleDeleteAll: _handleDeleteAll)
                : SizedBox(
                    height: 0,
                  ),
            SearchItem(
                handleSearch: _handlePress,
                handleClose: close,
                handleDelete: _handleDelete,
                recent: recentSearched.lastSearchChorus[index])
          ]);
        },
      );
    } else if (query.length >= 3) {
      provSearch.searchChorus = query;
      suggest = songs
          .where((e) => removeDiacritics(e.song.toLowerCase().trim())
              .contains(removeDiacritics(query.toLowerCase().trim())))
          .toList();
    } else {
      Random rnd = new Random(date.day);
      final random = rnd.nextInt(songs.length - 10);

      suggest = songs.getRange(random, random + 10).toList();
    }
    if (suggest.length == 0) {
      return emptyState(context, "No existen coros con tu",
          Icons.not_interested_sharp, "criterio de busqueda..!");
    } else {
      return ListView.builder(
          itemCount: suggest.length,
          itemBuilder: (ctx, i) {
            final chorusDB = Provider.of<FavoriteChorusAppProvider>(context);

            final isFavorite = chorusDB.favoriteChorus
                .map((e) => e.id)
                .toList()
                .contains(suggest[i].id);
            return itemChorusWid(ctx, suggest[i], isFavorite);
          });
    }
  }

  _handlePress(String recentSearched) {
    query = recentSearched;
  }

  _handleDelete(String recentSearhText) {
    recentSearched.lastSearchProvider = recentSearhText;
  }

  _handleDeleteAll() {
    recentSearched.removeAllChorusSearched();
  }
}
