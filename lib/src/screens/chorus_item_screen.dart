import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChorusLirycsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final _pref = SharedPreferencesUtil();
    final chorusProvider = Provider.of<ChorusJsonProvider>(context);
    final favoriteDb = Provider.of<FavoriteChorusAppProvider>(context);

    final int chorusId = args['id'];
    final String where = args['where'];

    _pref.lastPage = 'chorusLirycsScreen';
    _pref.lastIdSong = chorusId;

    final Song chorus =
        chorusProvider.chorus.firstWhere((song) => song.id == chorusId);

    chorus.type = 'chorus';

    final saved =
        favoriteDb.favoriteChorus.map((e) => e.id).toList().contains(chorus.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (where == 'splash') {
                Navigator.of(context).pushReplacementNamed('homeScreen');
                return;
              }
              Navigator.of(context).pop();
            }),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          chorus.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline1,
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    chorus.song,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      shadows: [
                        Shadow(blurRadius: 3, color: Colors.white10),
                      ],
                    ),
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
