import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/models/Note/note.dart';
import 'package:pintassilgo/models/genericDAO.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteDAO extends GenericDAO<Note> {

  @override
  String table = "tbNote";

  @override
  Note fromMap(item){
    Note.fromMap(item);
    return Note.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Note object){
    return object.toMap();
  }

  Future<List<Note>> notesByImage(int id) async{
    Database db = await DatabaseHelper.instance.database;
    var objects = await db.query(table, where: "idImage = ?", whereArgs: [id]);

    print('Puxando notas do banco... ${objects}');

    List<Note> objectList = objects.isNotEmpty
    ? objects.map((item) => fromMap(item)).toList()
    : [];

    return objectList;
  }

}