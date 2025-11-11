class Folder {
  int? id;
  String name;
  int? idUser;

  Folder({required this.name, this.id, this.idUser}); 

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
    id: json['id'],
    name: json['name'],
    idUser : json['idUser']
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'idUser': idUser
    };
  }

}