import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/genericDAO.dart';
import 'package:sqflite/sqlite_api.dart';

class FolderDAO extends GenericDAO<Folder> {

  @override
  String table = "tb_folder"; 

  @override
  Folder fromMap(item){
    Folder.fromMap(item);
    return Folder.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Folder object){
    return object.toMap();
  }

  //List<Folder> foldersByUser(int id) async{
  //  Database db = await DatabaseHelper.instance.database;
  //  var objects = await db.query(table, where: "idUser = ?", whereArgs: [id]);
//
  //  List<Folder> objectList = objects.isNotEmpty
  //  ? objects.map((item) => fromMap(item)).toList()
  //  : [];
//
  //  return Future(objectList);
  //}

}