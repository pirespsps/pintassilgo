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
      Tables...
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