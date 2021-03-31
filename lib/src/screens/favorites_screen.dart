import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_ui_provider.dart';
import 'package:chorus_app/src/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Fav();
  }
}

class Fav extends StatelessWidget {
  const Fav({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteChorusAppProvider>(context);
    final _favProvider = Provider.of<FavoriteUiProvider>(context);
    final tabText = _favProvider.tab == 0 ? 'Coros' : 'Himnos';
    final favoritesTab = favorite.favoriteChorus
        .where((e) => e.type == _favProvider.tabName)
        .toList();

    final favoriteItem = favoritesTab.length == 0
        ? emptyState(context, 'Aun no has guardado $tabText', Icons.save_alt,
            "como favoritos")
        : _favoriteLayout(context, favoritesTab);

    return SafeArea(
        child: favorite.favoriteChorus.length > 0
            ? ListView(
                physics: BouncingScrollPhysics(parent: ScrollPhysics()),
                children: [
                  Column(
                    children: [
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          favoriteItem,
                        ],
                      ))
                    ],
                  )
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: emptyState(context, "No has guardado coros ni himnos",
                    Icons.save_alt_outlined, "como favoritos"),
              ));
  }

  Widget _favoriteLayout(BuildContext ctx, List<Song> songs) {
    return Column(
        children: songs.map((e) => favoriteItemWidget(ctx, e, true)).toList());
  }
}

Widget favoriteItemWidget(BuildContext ctx, Song chorus, bool isFavorite) =>
    _favoriteItem(ctx, chorus, isFavorite);

Widget _favoriteItem(BuildContext ctx, Song song, bool favorite) {
  final chorusDB = Provider.of<FavoriteChorusAppProvider>(ctx);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 7.0),
    child: Column(children: [
      SizedBox(
        height: 2.0,
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          enableFeedback: true,
          title: GestureDetector(
            child: Text(
              song.title,
              style: Theme.of(ctx).primaryTextTheme.headline3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            onTap: () => _handleNavigate(ctx, song.id, song.type),
          ),
          trailing: IconButton(
            icon: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: () {
              favorite
                  ? chorusDB.deleteChorusById(song.id)
                  : chorusDB.newFavorite(song);
            },
          ),
        ),
      ),
    ]),
  );
}

_handleNavigate(BuildContext ctx, int id, String type) {
  switch (type) {
    case 'chorus':
      Navigator.pushNamed(ctx, 'chorusLirycsScreen', arguments: id);
      break;
    case 'hymn':
      Navigator.pushNamed(ctx, 'hymnScreenLirycsScreen', arguments: id);
      break;
    default:
  }
}
