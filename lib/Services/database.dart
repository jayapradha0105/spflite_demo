import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thiran_demo/Model/repo.dart';

class DatabaseHelper {
  static final _databaseName = "GitHubDB.db";
  static final _databaseVersion = 1;

  static final table = 'githublist_table';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnUsername = 'username';
  static final columnAvatar = 'avatar';
  static final columnRating = 'rating';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    // print(_database);
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnAvatar TEXT NOT NULL,
            $columnRating TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  Future<int> insert(Repo row) async {
    Database db = await instance.database;
    return await db.insert(table, row.toJson());
  }

  Future<List<Repo>> queryAllRows() async {
    Database db = await instance.database;
    final res = await db.query(table);
    List<Repo> list =
        res.isNotEmpty ? res.map((c) => Repo.fromDBJson(c)).toList() : [];
    return list;
  }

  Future<List<Repo>> queryLimitRows(offset) async {
    Database db = await instance.database;
    final res = await db.query(table, limit: 10, offset: offset);
    List<Repo> list =
        res.isNotEmpty ? res.map((c) => Repo.fromDBJson(c)).toList() : [];
    return list;
  }


  Future<int> delete() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
