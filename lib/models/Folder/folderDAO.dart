import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/Image/imageDAO.dart';
import 'package:pintassilgo/models/genericDAO.dart';
import 'package:sqflite/sqlite_api.dart';

class FolderDAO extends GenericDAO<Folder> {

  @override
  String table = "tbFolder"; 

  @override
  Folder fromMap(item){
    Folder.fromMap(item);
    return Folder.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Folder object){
    return object.toMap();
  }

  Future<List<Folder>> foldersByUser(int id) async{
    Database db = await DatabaseHelper.instance.database;
    var objects = await db.query(table, where: "idUser = ?", whereArgs: [id]);

    print('Puxando pastas do banco...');

    List<Folder> objectList = objects.isNotEmpty
    ? objects.map((item) => fromMap(item)).toList()
    : [];

    return objectList;
  }

  Future<List<Folder>> foldersByUserView(int id) async{
    Database db = await DatabaseHelper.instance.database;
    var objects = await db.query(table, where: "idUser = ?", whereArgs: [id]);

    ImageDAO imageDao = ImageDAO();

    print('Puxando pastas do banco...');

    List<Folder> objectList = objects.isNotEmpty
    ? objects.map((item) {
        var folder = fromMap(item);
        return folder;
      }).toList()
    : [];

    for (int i = 0; i < objectList.length; i++) {
      var images = await imageDao.imagesByFolder(objectList[i].id!, 4);
      objectList[i].images = images;
    }

    return objectList;
  }

}