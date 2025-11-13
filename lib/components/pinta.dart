import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pintassilgo/models/Image/image.dart';

class Pinta extends StatelessWidget {
  final Imagem imagem;
  const Pinta({super.key, required this.imagem});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<Directory> documentsDirectory = getApplicationDocumentsDirectory();

    return SizedBox(
      width: size.width * 40 / 100,
      height: size.width * 60 / 100,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FutureBuilder(
              future: documentsDirectory,
              builder: (context, asyncSnapshot) {
                return Container(
                  width: size.width * 40 / 100,
                  height: size.width * 40 / 100,
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: asyncSnapshot.data != null ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(
                          join(
                            asyncSnapshot.data!.path,
                            "images/",
                            imagem.id!.toString() + ".png",
                          ),
                        )
                      )
                    ) : null
                  ),
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
            child: Text(
              imagem.title,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }
}