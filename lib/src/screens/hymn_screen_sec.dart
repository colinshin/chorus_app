import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnScreen extends StatelessWidget {
  const HymnScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hymnProv = Provider.of<ChorusJsonProvider>(context);
    final favoriteChorusProvider =
        Provider.of<FavoriteChorusAppProvider>(context);
    return SafeArea(
        child: ListView.builder(
            itemCount: hymnProv.hymns.length,
            itemBuilder: (BuildContext ctx, int idx) {
              final isFavorite = favoriteChorusProvider.favoriteChorus
                  .map((e) => e.id)
                  .toList()
                  .contains(hymnProv.hymns[idx].id);

              return _hymnItem(context, hymnProv.hymns[idx], isFavorite);
            }));
  }

  Widget _hymnItem(BuildContext ctx, Song hymn, bool favorite) {
    hymn.type = 'hymn';
    final favoriteProv = Provider.of<FavoriteChorusAppProvider>(ctx);
    return Column(children: [
      ListTile(
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
          child: Text((hymn.id).toString()),
          onTap: () => _handleNavigate(ctx, hymn.id),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Divider(),
      )
    ]);
  }

  _handleNavigate(BuildContext ctx, int id) {
    Navigator.pushNamed(ctx, 'hymnScreenLirycsScreen', arguments: id);
  }
}
