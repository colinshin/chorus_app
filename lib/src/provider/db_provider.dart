import 'dart:core';
import 'dart:io';

import 'package:chorus_app/src/models/song_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;

  final favoritesTbl = 'favorites';
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'worship.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database _db, int version) async {
      await _db.execute('''
           CREATE TABLE IF NOT EXISTS $favoritesTbl
           (
            id INTEGER NOT NULL UNIQUE,
            title TEXT NOT NULL,
            song TEXT NOT NULL,
            type TEXT NOT NULL
           );
           ''');
    });
  }

  Future<int> createFavoriteChorus(Song chorus) async {
    final db = await database;

    final res = await db.insert(favoritesTbl, chorus.toJson());

    return res;
  }

  Future<List<Song>> getChoruses() async {
    final db = await database;
    final res = await db.query(favoritesTbl);
    return res.isNotEmpty
        ? res.map((item) => Song.fromJson(item)).toList()
        : [];
  }

  Future<Song> getChorusById(int chorusId) async {
    final db = await database;
    final res =
        await db.query(favoritesTbl, where: '"id" = ?', whereArgs: [chorusId]);
    return res.isNotEmpty ? Song.fromJson(res.first) : null;
  }

  Future<bool> deleteChorusById(int chorusId) async {
    final db = await database;
    final res =
        await db.delete(favoritesTbl, where: 'id=?', whereArgs: [chorusId]);
    return res == 0 ? false : true;
  }

  Future<bool> deleteAllChorus() async {
    final db = await database;
    final res = await db.delete(favoritesTbl);
    return res == 0 ? false : true;
  }
}
