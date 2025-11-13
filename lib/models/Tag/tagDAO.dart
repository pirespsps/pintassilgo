import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/models/Tag/tag.dart';
import 'package:pintassilgo/models/genericDAO.dart';
import 'package:sqflite/sqlite_api.dart';

class TagDAO extends GenericDAO<Tag> {

  @override
  String table = "tbTag";

  @override
  Tag fromMap(item){
    return Tag.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Tag object){
    return object.toMap();
  }

  Future<List<Tag>> tagsByFolder(int idFolder) async {
    Database db = await DatabaseHelper.instance.database;

    var tags = await db.rawQuery('''
    SELECT tbTag.*
    FROM tbFolderTag
      INNER JOIN tbTag ON tbTag.id = tbFolderTag.idTag
    WHERE idFolder == $idFolder);
    ''');

    return tags.map((tag){return fromMap(tag);}).toList();

  }


}