import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/genericDAO.dart';
import 'package:sqflite/sqlite_api.dart';

class ImageDAO extends GenericDAO<Imagem> {

  @override
  String table = "tbImage";

  @override
  Imagem fromMap(item){
    Imagem.fromMap(item);
    return Imagem.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Imagem object){
    return object.toMap();
  }

  Future<List<Imagem>> imagesByFolder(int id, int? quantidade) async{
    Database db = await DatabaseHelper.instance.database;
    var objects = await db.query(table, where: "idFolder = ?", limit: quantidade , whereArgs: [id]);

    print('Puxando imagens do banco... ${objects}');

    List<Imagem> objectList = objects.isNotEmpty
    ? objects.map((item) => fromMap(item)).toList()
    : [];

    return objectList;
  }

}