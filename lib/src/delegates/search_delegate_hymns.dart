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

class HymnSearchDelegate extends SearchDelegate<String> {
  final List<Song> hymns;
  final DateTime date = DateTime.now();
  final LastSearchProvider recentSearched;
  final UiKeepDataSearched provSearch;
  final BuildContext ctx;
  HymnSearchDelegate(
      {@required this.hymns,
      @required this.provSearch,
      @required this.ctx,
      @required this.recentSearched})
      : super(
            keyboardType: TextInputType.text,
            searchFieldDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
              hintStyle: Theme.of(ctx)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20.0, color: Theme.of(ctx).primaryColor),
            ),
            searchFieldLabel:
                '${hymns[DateTime.now().day * Random().nextInt(8)].title}');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_sharp),
          onPressed: () {
            query = '';
            provSearch.searchHymn = query;
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
      recentSearched.lastSearchHymnProvider = query;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Song> suggest = [];

    if (recentSearched.lastSearchHymns.length != 0 && query.length == 0) {
      return ListView.builder(
        itemCount: recentSearched.lastSearchHymns.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              margin: EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.3)),
              child: Column(children: [
                index == 0
                    ? deleteAllSearched(
                        handleDeleteAll: _handleDeleteAll, ctx: context)
                    : SizedBox(
                        height: 0,
                      ),
                SearchItem(
                    handleSearch: _handlePress,
                    handleClose: close,
                    handleDelete: _handleDelete,
                    recent: recentSearched.lastSearchHymns[index])
              ]));
        },
      );
    } else if (query.length >= 0) {
      provSearch.searchHymn = query;
      final id = int.tryParse(query) != null ? int.tryParse(query) : -1;
      suggest = hymns
          .where((e) =>
              e.id == id ||
              removeDiacritics(e.song.toLowerCase().trim())
                  .contains(removeDiacritics(query.toLowerCase().trim())))
          .toList();
    } else {
      Random rnd = new Random(date.day);
      final random = rnd.nextInt(hymns.length - 10);
      suggest = hymns.getRange(random, random + 10).toList();
    }
    if (suggest.length == 0) {
      return emptyState(context, "No existen himno con tu",
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

            final item = suggest[i];
            item.type = 'hymn';

            return itemChorusWid(ctx, item, isFavorite);
          });
    }
  }

  _handlePress(String recentSearched) {
    query = recentSearched;
  }

  _handleDelete(String recentSearhText) {
    recentSearched.lastSearchHymnProvider = recentSearhText;
  }

  _handleDeleteAll() {
    recentSearched.removeAllHymnSearched();
  }
}
