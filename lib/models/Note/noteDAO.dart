import 'package:pintassilgo/models/Note/note.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class Userdao extends GenericDAO<Note> {

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