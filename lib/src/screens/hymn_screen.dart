import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/ui_scroll_list_view.dart';
import 'package:chorus_app/src/widgets/hymn_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnScreen extends StatelessWidget {
  const HymnScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hymnProv = Provider.of<ChorusJsonProvider>(context);
    final _provScroll = Provider.of<UiKeepScroll>(context);

    final favoriteChorusProvider =
        Provider.of<FavoriteChorusAppProvider>(context);
    ScrollController _sc = ScrollController(
        keepScrollOffset: true, initialScrollOffset: _provScroll.scrollHymn);

    return SafeArea(
        child: Scrollbar(
      controller: _sc,
      isAlwaysShown: true,
      thickness: 4,
      notificationPredicate: (Notification n) {
        if (n is ScrollEndNotification) {
          _provScroll.scrollHymn = _sc.offset;
          return true;
        }
        return true;
      },
      child: ListView.builder(
          controller: _sc,
          itemCount: hymnProv.hymns.length,
          cacheExtent: 200,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
