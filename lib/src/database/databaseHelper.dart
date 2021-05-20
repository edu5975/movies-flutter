import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/favoriteDao.dart';
import 'package:practica2/src/models/userDao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final String _nombreBD = "MOVIESDB";
  static final int _versionDB = 1;

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else {
      _database = await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreBD);
    return await openDatabase(
      rutaDB,
      version: _versionDB,
      onCreate: _scriptDatabase,
    );
  }

  _scriptDatabase(Database db, int version) async {
    await db.execute('create table tbl_user(' +
        'id integer primary key,' +
        'user varchar(25),' +
        'phone varchar(25),' +
        'email varchar(40),' +
        'picture varchar(200)' +
        ')');
    await db.execute("CREATE TABLE tbl_favorite(" +
        "id INTEGER PRIMARY KEY," +
        "id_user INTEGER, " +
        "id_movie INTEGER," +
        "title varchar(20)," +
        "overview varchar(20)," +
        "poster_path varchar(200)," +
        "backdrop_path varchar(20)," +
        "release_date varchar(20)," +
        "vote_average float" +
        ")");
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    var connection = await database;
    return await connection.insert(
      table,
      values,
    );
  }

  Future<int> update(String table, Map<String, dynamic> values) async {
    var connection = await database;
    return await connection.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [
        values['id'],
      ],
    );
  }

  Future<int> delete(String table, int id) async {
    var connection = await database;
    return await connection.delete(
      table,
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }

  Future<UserDao> getUser(String email) async {
    var connection = await database;
    var results = await connection.query(
      'tbl_user',
      where: 'email = ?',
      whereArgs: [email],
    );
    var lista = (results).map((u) => UserDao.fromJSON(u)).toList();
    if (lista.length > 0)
      return lista[0];
    else
      return null;
  }

  Future<FavoriteDao> getFavoriteMovies(int idMovie, int idUser) async {
    var dbClient = await database;
    var result = await dbClient.query('tbl_favorite',
        where: "id_movie = ? and id_user = ?", whereArgs: [idMovie, idUser]);
    var lista = result.map((item) => FavoriteDao.fromJSON(item)).toList();
    return lista.length > 0 ? lista[0] : null;
  }

  Future<List<FavoriteDao>> getFavoritesMovies(int idUser) async {
    var dbClient = await database;
    var result = await dbClient.query(
      'tbl_favorite',
      where: "id_user = ?",
      whereArgs: [idUser],
      orderBy: "id desc",
    );
    var lista = result.map((item) => FavoriteDao.fromJSON(item)).toList();
    return lista.length > 0 ? lista : null;
  }
}
