

import 'package:pintassilgo/models/Image/image.dart';

class Folder {
  int? id;
  String name;
  int? idUser;
  bool isLiked;

  List<Imagem>? images;

  Folder({required this.name, this.id, this.idUser, this.isLiked = false}); 

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
    id: json['id'],
    name: json['name'],
    idUser : json['idUser'],
    isLiked : json['isLiked'] == 1 ? true : false
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'idUser': idUser,
      'isLiked' : isLiked ? 1 : 0
    };
  }

  void like() {
    isLiked = !isLiked;
  }
}