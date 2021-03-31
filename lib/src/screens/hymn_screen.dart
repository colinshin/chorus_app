import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/widgets/hymn_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnScreen extends StatelessWidget {
  const HymnScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hymnProv = Provider.of<ChorusJsonProvider>(context);
    final favoriteChorusProvider =
        Provider.of<FavoriteChorusAppProvider>(context);
    ScrollController _sc = ScrollController();

    return SafeArea(
        child: NotificationListener(
      onNotification: (t) {
        if (t is ScrollEndNotification) {
          print(_sc.position.pixels);
          return true;
        }
        return false;
      },
      child: ListView.builder(
          controller: _sc,
          physics: BouncingScrollPhysics(parent: ScrollPhysics()),
          addAutomaticKeepAlives: true,
          itemCount: hymnProv.hymns.length,
          itemBuilder: (BuildContext ctx, int idx) {
            final isFavorite = favoriteChorusProvider.favoriteChorus
                .map((e) => e.id)
                .toList()
                .contains(hymnProv.hymns[idx].id);

            return HymnItem(favorite: isFavorite, hymn: hymnProv.hymns[idx]);
          }),
    ));
  }
}
