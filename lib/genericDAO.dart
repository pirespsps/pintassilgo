import 'package:sqflite/sqflite.dart';
import 'package:pintassilgo/dataBaseHelper.dart';

abstract class GenericDAO<T> {

  T _fromMap(item);
  Map<String, dynamic> _toMap(object);

  Future<int> add(T object, String table) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, _toMap(object));
  }

  Future<int> remove(int id, String table) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(T object, int id, table)async{
    Database db = await DatabaseHelper.instance.database;
    return await db.update(table, _toMap(object), where: 'id = ?', whereArgs: [id]);
  }

  Future<List<T>> list(String table) async{
    Database db = await DatabaseHelper.instance.database;
    var objects = await db.query(table);

    List<T> objectList = objects.isNotEmpty
    ? objects.map((item) => _fromMap(item)).toList()
    : [];

    return objectList;
  }

}