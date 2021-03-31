import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChorusLirycsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int chorusId = ModalRoute.of(context).settings.arguments;
    final chorusProvider = Provider.of<ChorusJsonProvider>(context);
    final favoriteDb = Provider.of<FavoriteChorusAppProvider>(context);

    final Song chorus =
        chorusProvider.chorus.firstWhere((song) => song.id == chorusId);

    chorus.type = 'chorus';

    final saved =
        favoriteDb.favoriteChorus.map((e) => e.id).toList().contains(chorus.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          chorus.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 2.0,
        actions: [
          IconButton(
            icon: Icon(
              saved ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: () => saved
                ? favoriteDb.deleteChorusById(chorus.id)
                : favoriteDb.newFavorite(chorus),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(parent: ScrollPhysics()),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    chorus.song,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
