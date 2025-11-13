class Image {
  int? id;
  String title;
  DateTime date;
  int? idFolder;
  bool isFavorite;
  String fileExtension;

  Image({required this.title, required this.date, required this.idFolder, this.isFavorite = false, this.id, required this.fileExtension}); 

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    id: json['id'],
    title: json['title'],
    date: DateTime.parse(json['date']),
    idFolder: json['idFolder'],
    isFavorite: json['isFavorite'],
    fileExtension: json['fileExtension'],
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'date' : date.toIso8601String(),
      'idFolder' : idFolder,
      'isFavorite' : isFavorite,
      'fileExtension' : fileExtension,
    };
  }

}