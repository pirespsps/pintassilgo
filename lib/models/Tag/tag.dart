import 'package:flutter/material.dart';

class Tag {
  int? id;
  String name;
  String color;

  Tag({required this.name, required this.color, this.id});

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
    id: json['id'],
    name: json['name'],
    color: json['color'],
  );

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'color' : color,
    };
  } 
}