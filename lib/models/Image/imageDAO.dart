import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class Userdao extends GenericDAO<Image> {

  @override
  Image fromMap(item){
    Image.fromMap(item);
    return Image.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(Image object){
    return object.toMap();
  }

}