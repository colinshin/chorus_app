import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnItem extends StatelessWidget {
  final Song hymn;
  final bool favorite;

  const HymnItem({@required this.favorite, @required this.hymn});

  @override
  Widget build(BuildContext ctx) {
    final favoriteProv = Provider.of<FavoriteChorusAppProvider>(ctx);
    hymn.type = 'hymn';
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
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
                  hymn.title,
                  style: Theme.of(ctx).primaryTextTheme.headline3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                onTap: () {
                  _handleNavigate(ctx, hymn.id);
                },
              ),
              trailing: GestureDetector(
                  child: Icon(
                    !favorite ? Icons.favorite_border : Icons.favorite,
                    color: Colors.redAccent,
                  ),
                  onTap: () => !favorite
                      ? favoriteProv.newFavorite(hymn)
                      : favoriteProv.deleteChorusById(hymn.id)),
              leading: GestureDetector(
                child: Text(('#${hymn.id}')),
                onTap: () => _handleNavigate(ctx, hymn.id),
              ),
            ),
          )
        ]));
  }

  _handleNavigate(BuildContext ctx, int id) {
    Navigator.pushNamed(ctx, 'hymnScreenLirycsScreen',
        arguments: {'id': id, 'where': 'item'});
  }
}
