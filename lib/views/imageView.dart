import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/Note/note.dart';
import 'package:pintassilgo/models/Note/noteDAO.dart';

class Imageview extends StatefulWidget {
  final Imagem imagem;
  const Imageview({super.key, required this.imagem});

  @override
  State<Imageview> createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  void update() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    NoteDAO noteDao = NoteDAO();

    Future<List<Note>> notas = noteDao.notesByImage(widget.imagem.id!);

    Future<Directory> documentsDirectory = getApplicationDocumentsDirectory();

    return Scaffold(
      body: Column(
        children: [
          
          Appbar(updateParent: update ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width * 1 / 100,
                  width: size.width,
                ),
                Center(
                  child: SizedBox(
                    width: size.width * 80 / 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.imagem.title,
                              style: TextStyle(
                                fontSize: 60,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit)
                            )
                          ],
                        ),
                        Text(
                          widget.imagem.date.toString().split(" ")[0],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 10 / 100,
                  width: size.width,
                ),
                FutureBuilder(
                  future: documentsDirectory,
                  builder: (context, asyncSnapshot) {
                    return Center(
                      child: Container(
                        width: size.width * 80 / 100,
                        height: size.width * 80 / 100,
                      
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: asyncSnapshot.data != null ? DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                join(
                                  asyncSnapshot.data!.path,
                                  "images/",
                                  widget.imagem.id!.toString() + ".png",
                                ),
                              )
                            )
                          ) : null
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(
                  height: size.width * 10 / 100,
                ),
                FutureBuilder(
                  future: notas, 
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              width: size.width * 80 / 100,

                              decoration: BoxDecoration(
                                color: colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50)
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(snapshot.data![index].title),
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return Center(
                        child: Container(
                          width: size.width * 80 / 100,

                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Não há notas para essa imagem!"),
                          ),
                        ),
                      );
                    }
                  }
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}