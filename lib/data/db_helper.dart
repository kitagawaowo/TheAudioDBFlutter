import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'album.dart';

class DbHelper {
  final int version = 1;
  final String databaseName = 'music.db';
  final String tableName = 'albums';

  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (database, version) {
        database.execute(
            'create table $tableName (id text primary key, name text, artist text, year text, poster text)');
      },
      version: version,
    );
    return db as Database;
  }

  insert(Album album) async {
    await db?.insert(tableName, album.toMap());
  }

  delete(Album album) async {
    await db?.delete(tableName, where: 'id=?', whereArgs: [album.id]);
  }

  Future<bool> isFavorite(Album album) async {
    final maps =
        await db?.query(tableName, where: 'id=?', whereArgs: [album.id]);
    return maps!.isNotEmpty;
  }

  Future<List<Album>>> fetchAll() async {
    final maps = await db?.query(tableName);
    List<Album> albums = maps!.map((e) => Album.fromMap(map)).toList();
  }
}
