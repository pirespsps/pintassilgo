class Note {
  int? id;
  String title;
  String? text;
  int idImage;
  String? link;

  Note({required this.title, this.text, required this.idImage, this.link, this.id});

  factory Note.fromMap(Map<String, dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    text: json['text'],
    idImage: json['idImage'],
    link: json['link']
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'text' : text,
      'idImage' : idImage,
      'link' : link
    };
  } 
}