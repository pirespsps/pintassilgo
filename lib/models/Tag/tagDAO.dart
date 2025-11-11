import 'package:pintassilgo/models/Tag/tag.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class TagDAO extends GenericDAO<Tag> {

  @override
  String table = "tbTag";

  @override
  Tag fromMap(item){
    Tag.fromMap(item);
    return Tag.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Tag object){
    return object.toMap();
  }

}