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

  Future<User?> login(User user) async{
    final Database db = await DatabaseHelper.instance.database;

    var resultado = await db.rawQuery(
      "select * from tbUser where name = '${user.name}' AND password = '${user.password}'"
    );
    if (resultado.isNotEmpty){
      return User.fromMap(resultado.first);
    }else{
      return null;
    }
  }

  Future <int> registro(User user) async{
    final Database db = await DatabaseHelper.instance.database;

    return db.insert('tbUser', user.toMap());
  }

}