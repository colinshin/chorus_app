import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/widgets/chorus_item_widget.dart';
import 'package:chorus_app/src/widgets/empty_state_widget.dart';
import 'package:chorus_app/src/widgets/hymn_item.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:provider/provider.dart';

class FavoriteChorusSearch extends SearchDelegate {
  final List<Song> choruses;
  final String type;

  FavoriteChorusSearch({@required this.choruses, @required this.type});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_sharp),
          onPressed: () {
            query = '';
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
    print("CLOSE SEARCH DELEGATE ....................");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Song> suggest = [];

    if (query.length >= 3) {
      suggest = choruses
          .where((e) => removeDiacritics(e.song.toLowerCase().trim())
              .contains(removeDiacritics(query.toLowerCase().trim())))
          .toList();
    } else {
      suggest = choruses;
    }
    if (suggest.length == 0) {
      return emptyState(context, "No existen himnos con tu",
          Icons.not_interested_sharp, "criterio de busqueda..!");
    }
    return ListView.builder(
        itemCount: suggest.length,
        itemBuilder: (ctx, i) {
          final chorusDB = Provider.of<FavoriteChorusAppProvider>(context);

          final isFavorite = chorusDB.favoriteChorus
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
