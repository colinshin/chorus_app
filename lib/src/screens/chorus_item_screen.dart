import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/chorus_provider.dart';
import 'package:chorus_app/src/provider/favorite_chorus_provider.dart';
import 'package:chorus_app/src/provider/theme_provider.dart';
import 'package:chorus_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

class ChorusLirycsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final _pref = SharedPreferencesUtil();
    final chorusProvider = Provider.of<ChorusJsonProvider>(context);
    final favoriteDb = Provider.of<FavoriteChorusAppProvider>(context);
    final _provTheme = Provider.of<UiSharedPreferencesProvider>(context);
    final int chorusId = args['id'];
    final String where = args['where'];

    _pref.lastPage = 'chorusLirycsScreen';
    _pref.lastIdSong = chorusId;

    final Song chorus =
        chorusProvider.chorus.firstWhere((song) => song.id == chorusId);

    chorus.type = 'chorus';

    final _share =
        '\n *Corario pentecostes unido*\n*${chorus.title}*\n```${chorus.song}```\ndescarga esta app desde google drive ';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coro para alabar',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Colors.black, fontSize: 25.0),
            ),
          ],
        ),
        elevation: 2.0,
        actions: [
          IconButton(
            icon: Icon(
              saved ? Icons.favorite : Icons.favorite_border,
              color: _provTheme.darkTheme ? Colors.white : Colors.redAccent,
            ),
            onPressed: () => saved
                ? favoriteDb.deleteChorusById(chorus.id)
                : favoriteDb.newFavorite(chorus),
          ),
          IconButton(
              icon: Icon(
                Icons.share_sharp,
                color: _provTheme.darkTheme ? Colors.white : Colors.redAccent,
              ),
              onPressed: () {
                SocialShare.checkInstalledAppsForShare().then((value) {
                  SocialShare.shareOptions(_share)
                      .then((value) => print(value))
                      .onError((error, stackTrace) {});
                }).onError((error, stackTrace) {});
              })
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(chorus.title,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 27)),
                  ),
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
