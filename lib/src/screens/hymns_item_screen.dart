import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnLirycsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    final chorusProvider = Provider.of<ChorusJsonProvider>(context);
    final favoritesDB = Provider.of<FavoriteChorusAppProvider>(context);
    final _pref = SharedPreferencesUtil();

    final hymnId = args['id'];
    final String where = args['where'];
    _pref.lastPage = 'hymnScreenLirycsScreen';
    _pref.lastIdSong = hymnId;

    final Song hymn = chorusProvider.hymns.firstWhere((x) => x.id == hymnId);
    hymn.type = 'hymn';

    final saved =
        favoritesDB.favoriteChorus.map((e) => e.id).toList().contains(hymn.id);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black26,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(hymn.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline1),
        elevation: 2.0,
        actions: [
          IconButton(
            icon: Icon(
              !saved ? Icons.favorite_border : Icons.favorite,
              color: Colors.redAccent,
            ),
            onPressed: () => !saved
                ? favoritesDB.newFavorite(hymn)
                : favoritesDB.deleteChorusById(hymn.id),
          )
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (where == 'splash') {
                Navigator.of(context).pushReplacementNamed('homeScreen');
                return;
              }
              Navigator.of(context).pop();
            }),
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
