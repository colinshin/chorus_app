import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/widgets/chorus_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChorusScreen extends StatelessWidget {
  const ChorusScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final chorusProv = Provider.of<ChorusJsonProvider>(context);
    final chorusDB = Provider.of<FavoriteChorusAppProvider>(context);

    return SafeArea(
        child: ListView.builder(
            itemCount: chorusProv.chorus.length,
            physics: BouncingScrollPhysics(parent: ScrollPhysics()),
            itemBuilder: (BuildContext ctx, int idx) {
              chorusProv.chorus[idx].type = "chorus";

              final isFavorite = chorusDB.favoriteChorus
                  .map((e) => e.id)
                  .toList()
                  .contains(chorusProv.chorus[idx].id);

              return itemChorusWid(context, chorusProv.chorus[idx], isFavorite);
            }));
  }
}
