import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/ui_search_keep_data.dart';
import 'package:chorus_app/src/widgets/chorus_item_widget.dart';
import 'package:chorus_app/src/widgets/empty_state_widget.dart';
import 'package:chorus_app/src/widgets/hymn_item.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

class FavoriteChorusSearch extends SearchDelegate {
  final FavoriteChorusAppProvider choruses;
  final String type;
  final String label;
  final UiKeepDataSearched provSearch;

  FavoriteChorusSearch(
      {@required this.choruses,
      @required this.type,
      @required this.label,
      @required this.provSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_sharp),
          onPressed: () {
            query = '';
            provSearch.searchFavorite = query;
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Song> suggest = choruses.favoriteChorus
        .where((element) => element.type == type)
        .toList();

    if (query.length >= 3) {
      provSearch.searchFavorite = query;
      suggest = suggest
          .where((e) => removeDiacritics(e.song.toLowerCase().trim())
              .contains(removeDiacritics(query.toLowerCase().trim())))
          .toList();
    }
    if (suggest.length == 0) {
      return emptyState(context, 'No existen $label con tu',
          Icons.not_interested_sharp, "criterio de busqueda..!");
    }

    return ListView.builder(
        itemCount: suggest.length,
        itemBuilder: (ctx, i) {
          final isFavorite = choruses.favoriteChorus
              .map((e) => e.id)
              .toList()
              .contains(suggest[i].id);
          final data = suggest[i];
          data.type = type;
          if (type == 'hymn') {
            return HymnItem(favorite: isFavorite, hymn: data);
          }
          return itemChorusWid(context, data, isFavorite);
        });
  }
}
