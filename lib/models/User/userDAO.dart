import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/models/genericDAO.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDAO extends GenericDAO<User> {

  @override
  String table = "tbUser";

  @override
  User fromMap(item){
    return User.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(User object){
    return object.toMap();
  }

  Future<User?> getByNameAndPassword(String name, String password) async {
    Database db = await DatabaseHelper.instance.database;
    var object = await db.query(table, where: "name = ? AND password = ?", whereArgs: [name,password]);

    User? user = object.isNotEmpty
    ? fromMap(object.first)
    : null;

    return user;

  } 

}