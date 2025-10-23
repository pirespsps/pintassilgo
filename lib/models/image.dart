class Image {
  int? id;
  String title;
  DateTime data;
  int idPasta;
  bool isFavorite;

  Image({required this.title, required this.data, required this.idPasta, this.isFavorite = false, this.id}); 
}