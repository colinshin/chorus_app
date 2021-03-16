import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnLirycsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int hymnId = ModalRoute.of(context).settings.arguments;
    final chorusProvider = Provider.of<ChorusJsonProvider>(context);
    final favoritesDB = Provider.of<FavoriteChorusAppProvider>(context);

    final Song hymn = chorusProvider.hymns.firstWhere((x) => x.id == hymnId);
    hymn.type = 'hymn';

    final saved =
        favoritesDB.favoriteChorus.map((e) => e.id).toList().contains(hymn.id);
        
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black26,
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          hymn.title,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 2.0,
        actions: [
          GestureDetector(
            child: Icon(
              !saved ? Icons.favorite_border : Icons.favorite,
              color: Colors.redAccent,
            ),
            onTap: () => !saved
                ? favoritesDB.newFavorite(hymn)
                : favoritesDB.deleteChorusById(hymn.id),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    hymn.song,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
