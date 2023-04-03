import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'novelmodel.dart';
import 'usermodel.dart';

class DatabaseHelper {
  static const _databaseName = 'NewNovelDatabase.db';
  static const _databaseVersion = 2;

  static const tableUsers = 'users';
  static const tableNovels = 'novels';

  // Columns for users table
  static const columnUserId = 'user_id';
  static const columnUsername = 'username';
  static const columnPassword = 'password';
  static const columnRole = 'role';
  static const columnEmail = 'email';
  static const columnPhone = 'phone';

  // Columns for novels table
  static const columnNovelId = 'id';
  static const columnNovelTitle = 'title';
  static const columnNovelImage = 'imageUrl';
  static const columnNovelSource = 'source';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database and create tables for users and novels
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUsers (
            $columnUserId INTEGER PRIMARY KEY,
            $columnUsername TEXT NOT NULL UNIQUE,
            $columnPassword TEXT NOT NULL,
            $columnRole TEXT NOT NULL,
            $columnEmail TEXT,
            $columnPhone TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableNovels (
            $columnNovelId INTEGER PRIMARY KEY,
            $columnNovelTitle TEXT NOT NULL,
            $columnNovelImage TEXT NOT NULL,
            $columnNovelSource TEXT NOT NULL
          )
          ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
            CREATE TABLE $tableNovels (
              $columnNovelId INTEGER PRIMARY KEY,
              $columnNovelTitle TEXT NOT NULL,
              $columnNovelImage TEXT NOT NULL,
              $columnNovelSource TEXT NOT NULL
            )
            ''');
    }
  }

  // CRUD operations for users
  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    int id = Sqflite.firstIntValue(
            await db.rawQuery('SELECT MAX($columnUserId) FROM $tableUsers')) ??
        0;
    user.user_id = id + 1;
    return await db.insert(tableUsers, user.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await instance.database;
    return await db.query(tableUsers);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db
        .delete(tableUsers, where: '$columnUserId = ?', whereArgs: [id]);
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnUserId];
    String sql = 'UPDATE $tableUsers SET '
        '$columnUsername = ?, '
        '$columnPassword = ?, '
        '$columnEmail = ?, '
        '$columnPhone = ?, '
        '$columnRole = ? '
        'WHERE $columnUserId = ?';
    List<dynamic> params = [
      row[columnUsername],
      row[columnPassword],
      row[columnEmail],
      row[columnPhone],
      row[columnRole],
      id
    ];
    int result = await db.rawUpdate(sql, params);
    print('SQL: $sql, Params: $params, Result: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> queryUserByUsernameAndPassword(
      String username, String password) async {
    Database db = await instance.database;
    return await db.query(tableUsers,
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, password]);
  }

  Future<List<Map<String, dynamic>>> queryUserByUsername(
      String username) async {
    Database db = await instance.database;
    return await db
        .query(tableUsers, where: '$columnUsername = ?', whereArgs: [username]);
  }

// CRUD operations for novels
  Future<int> insertNovel(Novel novel) async {
    Database db = await instance.database;
    int id = Sqflite.firstIntValue(await db
            .rawQuery('SELECT MAX($columnNovelId) FROM $tableNovels')) ??
        0;
    novel.id = id + 1;
    return await db.insert(tableNovels, novel.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllNovels() async {
    Database db = await instance.database;
    return await db.query(tableNovels);
  }

  Future<int> deleteNovel(int id) async {
    Database db = await instance.database;
    return await db
        .delete(tableNovels, where: '$columnNovelId = ?', whereArgs: [id]);
  }

  Future<int> updateNovel(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnNovelId];
    String sql = 'UPDATE $tableNovels SET '
        '$columnNovelTitle = ?, '
        '$columnNovelImage = ?, '
        '$columnNovelSource = ? '
        'WHERE $columnNovelId = ?';
    List<dynamic> params = [
      row[columnNovelTitle],
      row[columnNovelImage],
      row[columnNovelSource],
      id
    ];
    int result = await db.rawUpdate(sql, params);
    print('SQL: $sql, Params: $params, Result: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> queryNovelById(int id) async {
    Database db = await instance.database;
    return await db
        .query(tableNovels, where: '$columnNovelId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryNovelByTitle(String title) async {
    Database db = await instance.database;
    return await db
        .query(tableNovels, where: '$columnNovelTitle = ?', whereArgs: [title]);
  }
}
