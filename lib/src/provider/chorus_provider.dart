import 'dart:convert';

import 'package:chorus_app/src/models/song_model.dart';
import 'package:chorus_app/src/utils/file_read.dart';
import 'package:flutter/foundation.dart';

class ChorusJsonProvider extends ChangeNotifier {
  static final ChorusJsonProvider _chorusJsonProvider =
      ChorusJsonProvider._internal();

  factory ChorusJsonProvider() => _chorusJsonProvider;

  ChorusJsonProvider._internal();

  List<Song> _chorus = [];
  List<Song> _hymns = [];

  Future<List<dynamic>> _loadJsonFile(String jsonKey) async {
    final file = new FileRead();
    final fileString = await file.loadFromAsset(filePath: 'assets/chorus.json');
    final dataRaw = jsonDecode(fileString);
    final List<dynamic> data = dataRaw[jsonKey];
    return data;
  }

  Future<void> getChorus() async {
    final dataJson = await _loadJsonFile('chorus');

    dataJson.forEach((value) {
      final chorusTemp = new Song.fromJson(value);
      _chorus.add(chorusTemp);
    });
    notifyListeners();
  }

  List<Song> get chorus {
    return this._chorus;
  }

  Future<void> getHymns() async {
    final dataJson = await _loadJsonFile('hymns');

    dataJson.forEach((value) {
      final hymnTemp = new Song.fromJson(value);
      _hymns.add(hymnTemp);
    });

    notifyListeners();
  }

  List<Song> get hymns {
    return this._hymns;
  }
}
