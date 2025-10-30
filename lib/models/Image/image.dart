class Image {
  int? id;
  String title;
  DateTime date;
  int idFolder;
  bool isFavorite;

  Image({required this.title, required this.date, required this.idFolder, this.isFavorite = false, this.id}); 

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    id: json['id'],
    title: json['title'],
    date: json['date'],
    idFolder: json['idFolder'],
    isFavorite: json['isFavorite']
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'date' : date,
      'idFolder' : idFolder,
      'isFavorite' : isFavorite
    };
  }

}