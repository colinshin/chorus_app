import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/provider/db_provider.dart';
import 'package:flutter/material.dart';

class FavoriteChorusAppProvider extends ChangeNotifier {
  List<Song> favoriteChorus = [];

  newFavorite(Song chorus) async {
    await DBProvider.db.createFavoriteChorus(chorus);
    this.favoriteChorus.add(chorus);
    getChorus();
  }

  getChorus() async {
    final choruses = await DBProvider.db.getChoruses();
    this.favoriteChorus = [...choruses];
    notifyListeners();
  }

  getChorusById(int chorusId) async {
    final chorus = await DBProvider.db.getChorusById(chorusId);
    this.favoriteChorus.add(chorus);
    notifyListeners();
  }

  deleteChorusById(int chorusId) async {
    final deleted = await DBProvider.db.deleteChorusById(chorusId);
    if (deleted) {
      this.favoriteChorus.removeWhere((chorus) => chorus.id == chorusId);

      notifyListeners();
    }
  }

  deleteChoruses() async {
    final deleted = await DBProvider.db.deleteAllChorus();
    if (deleted) {
      this.favoriteChorus = [];
      notifyListeners();
    }
  }
}
