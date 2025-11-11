import 'package:sqflite/sqflite.dart';
import 'package:pintassilgo/dataBaseHelper.dart';

abstract class GenericDAO<T> {

  T fromMap(item);
  Map<String, dynamic> toMap(T object);
  abstract String table;

  Future<int> add(T object) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, toMap(object));
  }

  Future<int> remove(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(T object, int id)async{
    Database db = await DatabaseHelper.instance.database;
    return await db.update(table, toMap(object), where: 'id = ?', whereArgs: [id]);
  }

  Future<List<T>> list() async{
    Database db = await DatabaseHelper.instance.database;
    var objects = await db.query(table);

    List<T> objectList = objects.isNotEmpty
    ? objects.map((item) => fromMap(item)).toList()
    : [];

    return objectList;
  }

}