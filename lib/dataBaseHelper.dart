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
      ); ''');

      await db.execute('''
      CREATE TABLE tbFolder(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL,
      idUser INT NOT NULL,
      isLiked INT NOT NULL,

      FOREIGN KEY (idUser) REFERENCES tbUser(id)
      );'''); 


      await db.execute('''
      CREATE TABLE tbImage(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      date TEXT,
      idFolder INTEGER NOT NULL, 
      isFavorite INTEGER,

      FOREIGN KEY (idFolder) REFERENCES tbFolder(id) ON DELETE CASCADE
      ); ''');

      await db.execute('''
      CREATE TABLE tbNote(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      title TEXT NOT NULL, 
      text TEXT, 
      idImage INT NOT NULL, 
      link TEXT, 

      FOREIGN KEY (idImage) REFERENCES tbImage(id) ON DELETE CASCADE
      ); ''');

      await db.execute('''
      CREATE TABLE tbTag(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL, 
      color INT NOT NULL
      );''');

      await db.execute(''' 
      CREATE TABLE tbImageTag(
      idImage INT NOT NULL, 
      idTag INT NOT NULL, 

      FOREIGN KEY (idImage) REFERENCES tbImage(id),
      FOREIGN KEY (idTag) REFERENCES tbTag(id),

      PRIMARY KEY (idImage,idTag)
      );''');

      await db.execute('''
      CREATE TABLE tbFolderTag(

      idFolder INTEGER NOT NULL,
      idTag INTEGER NOT NULL,
      
      FOREIGN KEY (idFolder) REFERENCES tbFolder(id) ON DELETE CASCADE, 
      FOREIGN KEY (idTag) REFERENCES tbTab(id),

      PRIMARY KEY (idFolder,idTag)
      ); ''');
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory(); //<---
    String path = join(documentsDirectory.path, _dbName);

    return openDatabase(path, onCreate: _createDb, onOpen: (db) async{
      await db.execute("PRAGMA foreign_keys = ON");
    }, version: _version);
  }

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<void> resetDatabase() async {

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, _dbName);

  if (_database != null) {
    await _database!.close();
    _database = null;
  }

  await deleteDatabase(path);

  _database = await _initDatabase();
}

}