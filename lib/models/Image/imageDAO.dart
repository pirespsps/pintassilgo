import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class ImageDAO extends GenericDAO<Image> {

  @override
  String table = "tbImage";

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