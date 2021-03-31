import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/widgets/chorus_item_widget.dart';
import 'package:chorus_app/src/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteChorusAppProvider>(context);

    return SafeArea(
        child: favorite.favoriteChorus.length > 0
            ? _createLisView(favorite.favoriteChorus)
            : emptyState(context, "Aun no has guardado", Icons.not_interested,
                "favoritos"));
  }

  _createLisView(List<Song> favoriteChorus) {
    return ListView.builder(
        itemCount: favoriteChorus.length,
        itemBuilder: (BuildContext ctx, int idx) {
          final item =
              favoriteChorus.firstWhere((s) => favoriteChorus[idx].id == s.id);

          return Column(
            children: [itemChorusWidget(ctx, item, true)],
          );
        });
  }
}
