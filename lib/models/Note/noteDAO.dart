import 'package:pintassilgo/models/Note/note.dart';
import 'package:pintassilgo/models/genericDAO.dart';

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

}