import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/Image/imageDAO.dart';
import 'package:pintassilgo/models/Note/note.dart';
import 'package:pintassilgo/models/Note/noteDAO.dart';
import 'package:pintassilgo/views/novaImagem.dart';

class Imageview extends StatefulWidget {
  final Imagem imagem;
  const Imageview({super.key, required this.imagem});

  @override
  State<Imageview> createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  void update() {
    setState(() {});
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
          Appbar(updateParent: update),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.width * 1 / 100, width: size.width),
                  Center(
                    child: SizedBox(
                      width: size.width * 80 / 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.keyboard_return, size: 50,)
                                ),
                                Text(
                                  widget.imagem.title,
                                  style: TextStyle(fontSize: 60),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await showDialog<String>(
                                      context: context,
                                      builder: (context) =>
                                          getDeleteDialog(context, widget.imagem),
                                    );
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.imagem.date.toString().split(" ")[0],
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 10 / 100, width: size.width),
                  FutureBuilder(
                    future: documentsDirectory,
                    builder: (context, asyncSnapshot) {
                      return Center(
                        child: Container(
                          width: size.width * 80 / 100,
                          height: size.width * 80 / 100,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: asyncSnapshot.data != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(
                                        join(
                                          asyncSnapshot.data!.path,
                                          "images/",
                                          widget.imagem.id!.toString() + ".png",
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
              
                  SizedBox(height: size.width * 10 / 100),
                  FutureBuilder(
                    future: notas,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == snapshot.data!.length) {
                              return Center(
                                child: IconButton(
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (context) => getNoteDialog(
                                        context,
                                        null,
                                        widget.imagem.id!,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.add, size: 40),
                                ),
                              );
                            }

                            return Center(
                              child: Container(
                                width: size.width * 80 / 100,

                                decoration: BoxDecoration(
                                  color: colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(50),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (context) => getNoteDialog(
                                          context,
                                          snapshot.data![index],
                                          null,
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Text(snapshot.data![index].title),
                                        Text(
                                          snapshot.data![index].text ?? "n/a",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length + 1,
                        );
                      } else {
                        return Center(
                          child: Container(
                            width: size.width * 80 / 100,

                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              borderRadius: BorderRadius.circular(50),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Não há notas para essa imagem!"),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Dialog getNoteDialog(context, Note? note, int? idImage) {
    final TextEditingController _tituloController = TextEditingController();
    final TextEditingController _textController = TextEditingController();
    final NoteDAO noteDAO = NoteDAO();

    if (note != null) {
      _tituloController.text = note.title;
      _textController.text = note.text ?? "";
    }

    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              note == null ? "criar nota" : "editar nota",
              textScaler: TextScaler.linear(2),
            ),

            SizedBox(
              height: 120,
              child: Column(
                spacing: 10,
                children: [
                  Field(
                    fieldController: _tituloController,
                    text: "titulo",
                    height: 20,
                  ),
                  Field(
                    fieldController: _textController,
                    text: "texto",
                    height: 40,
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    if (note == null) {
                      Note newNote = Note(
                        title: _tituloController.text,
                        text: _textController.text,
                        idImage: idImage!,
                      );
                      noteDAO.add(newNote);

                      setState(() {});

                      Navigator.pop(context);
                    } else {
                      note.title = _tituloController.text;
                      note.text = _textController.text;

                      noteDAO.update(note, note.id);

                      setState(() {});

                      Navigator.pop(context);
                    }
                  },
                  child: Text("confirmar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Dialog getDeleteDialog(context, Imagem image) {
    final ImageDAO imageDAO = ImageDAO();

    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text("voce tem certeza que deseja deletar a imagem?"),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    final Directory dir =
                        await getApplicationDocumentsDirectory();
                    final String path = join(dir.path, "images/");

                    File file = File(join(path, "${image.id}.png"));

                    await file.delete();

                    imageDAO.remove(image.id!);

                    Navigator.pop(context);
                  },
                  child: Text("confirmar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
