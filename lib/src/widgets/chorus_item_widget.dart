import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget itemChorusWidget(BuildContext ctx, Song chorus, bool isFavorite) =>
    _chorusItem(ctx, chorus, isFavorite);

Widget _chorusItem(BuildContext ctx, Song chorus, bool favorite) {
  final chorusDB = Provider.of<FavoriteChorusAppProvider>(ctx);
  return Column(children: [
    ListTile(
      enableFeedback: true,
      title: GestureDetector(
        child: Text(
          chorus.title,
          style: Theme.of(ctx).primaryTextTheme.headline3,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        onTap: () => _handleNavigate(ctx, chorus.id, chorus.type),
      ),
      trailing: GestureDetector(
        child: Icon(
          favorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.redAccent,
        ),
        onTap: () {
          favorite
              ? chorusDB.deleteChorusById(chorus.id)
              : chorusDB.newFavorite(chorus);
        },
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Divider(),
    )
  ]);
}

_handleNavigate(BuildContext ctx, int id, String type) {
  switch (type) {
    case 'chorus':
      Navigator.pushNamed(ctx, 'chorusLirycsScreen',
          arguments: {'id': id, 'where': 'item'});
      break;
    case 'hymn':
      Navigator.pushNamed(ctx, 'hymnScreenLirycsScreen',
          arguments: {'id': id, 'where': 'item'});
      break;
    default:
  }

  //
}

Widget itemChorusWid(BuildContext ctx, Song chorus, bool isFavorite) =>
    _chorusItemElement(ctx, chorus, isFavorite);

Widget _chorusItemElement(BuildContext ctx, Song chorus, bool favorite) {
  final chorusDB = Provider.of<FavoriteChorusAppProvider>(ctx);

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 2.0),
    child: Column(children: [
      SizedBox(
        height: 4.0,
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
              chorus.title,
              style: Theme.of(ctx).primaryTextTheme.headline3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            onTap: () => _handleNavigate(ctx, chorus.id, chorus.type),
          ),
          trailing: GestureDetector(
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onTap: () {
              favorite
                  ? chorusDB.deleteChorusById(chorus.id)
                  : chorusDB.newFavorite(chorus);
            },
          ),
        ),
      ),
    ]),
  );
}
