class Folder {
  int? id;
  String name;

  Folder({required this.name, this.id}); 

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
    };
  }

}