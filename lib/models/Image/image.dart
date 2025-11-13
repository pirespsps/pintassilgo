class Imagem {
  int? id;
  String title;
  DateTime date;
  int? idFolder;
  bool isFavorite;
  String fileExtension;

  Imagem({required this.title, required this.date, required this.idFolder, this.isFavorite = false, this.id, required this.fileExtension}); 

  factory Imagem.fromMap(Map<String, dynamic> json) => Imagem(
    id: json['id'],
    title: json['title'],
    date: DateTime.parse(json['date']),
    idFolder: json['idFolder'],
    isFavorite: json['isFavorite'] == 0 ? false : true,
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