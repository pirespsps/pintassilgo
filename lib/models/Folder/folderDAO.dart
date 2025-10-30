import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class Userdao extends GenericDAO<Folder> {

  @override
  Folder fromMap(item){
    Folder.fromMap(item);
    return Folder.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Folder object){
    return object.toMap();
  }

}