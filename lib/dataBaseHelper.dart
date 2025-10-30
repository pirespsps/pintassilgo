import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static const int _version = 1;

  static const String _dbName = "db_pintassilgo.db";

  Future _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tbUser(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL, 
      password TEXT NOT NULL
      );

      CREATE TABLE tbFolder(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL
      );

      CREATE TABLE tbImage(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      date TEXT NOT NULL,
      idFolder TEXT NOT NULL, 
      isFavorite INTEGER,

      FOREIGN KEY (idFolder) REFERENCES tbFolder (id)
      );

      CREATE TABLE tbNote(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      title TEXT NOT NULL, 
      text TEXT, 
      idImage INT NOT NULL, 
      link TEXT, 

      FOREIGN KEY (idImage) REFERENCES tbImage(id)
      );

      
    ''');
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory(); //<---
    String path = join(documentsDirectory.path, _dbName);

    return openDatabase(path, onCreate: _createDb, version: _version);
  }

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();
}