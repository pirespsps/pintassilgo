import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';
import 'package:pintassilgo/models/Image/image.dart' as image_model;
import 'package:pintassilgo/models/Image/imageDAO.dart';
import 'package:pintassilgo/models/Note/note.dart';
import 'package:pintassilgo/models/Note/noteDAO.dart';

class NovaImagem extends StatefulWidget {
  const NovaImagem({super.key});

  @override
  State<NovaImagem> createState() => _NovaImagemState();

  Future<String?> getUserId() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: "user");
  }

  Future<List<Folder>> getFolders() async {
    final FolderDAO folderDAO = FolderDAO();
    final id = await getUserId();
    if (id == null || id.isEmpty) {
      print("Id antes de parse null");
      return [];
    }

    final userId = int.tryParse(id);

    if(userId == null){
      print("Id depois de parse null");
      return [];
    }

    return await folderDAO.foldersByUser(userId);
  }
}

class _NovaImagemState extends State<NovaImagem> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _linksController = TextEditingController();

  late Future<List<Folder>> _foldersFuture;
  Folder? _selectedFolder;

  XFile? _image;

  @override
  void initState() {
    super.initState();
    _foldersFuture = widget.getFolders();
  }

  @override
  void dispose() {
    super.dispose();
    _tituloController.dispose();
    _notaController.dispose();
    _linksController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: MARROM_CLARO,
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 3),
          child: Column(
            spacing: 10,
            children: [
              Text(
                "nova foto",
                style: TextStyle(color: Colors.white),
                textScaler: TextScaler.linear(3),
              ),
              Container(height: 20),
              imageField(context, size),
              Form(
                key: _formkey,
                child: Column(
                  spacing: 10,
                  children: [
                    Field(
                      text: "título",
                      fieldController: _tituloController,
                      width: size.width - 50,
                      height: 65,
                    ),

                    Field(
                      text: "titulo da nota",
                      fieldController: _notaController,
                      width: size.width - 50,
                      height: 65,
                    ),

                    Field(
                      text: "links",
                      fieldController: _linksController,
                      width: size.width - 50,
                      height: 65,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Insira um valor, campo obrigatório";
                        }

                        if (!value.contains(".") || !value.contains("/")) {
                          return "Insira um link válido";
                        }

                        return null;
                      },
                    ),

                    Container(
                      width: size.width - 50,
                      decoration: BoxDecoration(
                        color: CINZA,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: FutureBuilder<List<Folder>>(
                          future: _foldersFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Erro ao carregar pastas: ${snapshot.error}",
                                ),
                              );
                            }

                            final folders = snapshot.data ?? [];

                            if (folders.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Pastas vazias",
                                ),
                              );
                            }

                            return DropdownButton<Folder>(
                              dropdownColor: CINZA,
                              style: TextStyle(color: MARROM),
                              menuWidth: size.width - 10,
                              icon: Padding(
                                padding: EdgeInsets.only(
                                  left: size.width - 140,
                                  right: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: MARROM,
                                  size: 40,
                                ),
                              ),
                              value: _selectedFolder,
                              items: folders.map((folder) {
                                return DropdownMenuItem<Folder>(
                                  value: folder,
                                  child: Text(folder.name),
                                );
                              }).toList(),
                              onChanged: (Folder? item) {
                                setState(() {
                                  _selectedFolder = item;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancelar"),
                  ),
                  FilledButton(
                    onPressed: () => {sendForm(context)},
                    child: Text("criar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendForm(context) async {
    if (_image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar( SnackBar(content: Text('Selecione uma imagem')));
      return;
    }

    if (_tituloController.text.isEmpty || _notaController.text.isEmpty) {
      return;
    }

    image_model.Image image = image_model.Image(
      title: _tituloController.text,
      date: DateTime.now(),
      idFolder: _selectedFolder!.id,
    );

    ImageDAO imagedao = ImageDAO();
    int id = await imagedao.add(image);

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory imagesDirectory = Directory(
      join(documentsDirectory.path, "images"),
    );

    if (!await imagesDirectory.exists()) {
      await imagesDirectory.create();
    }

    File file = File(
      join(
        documentsDirectory.path,
        "images/",
        id.toString(),
        ".",
        _image!.mimeType,
      ),
    );

    await file.writeAsBytes(await _image!.readAsBytes());

    NoteDAO noteDAO = NoteDAO();
    Note note = Note(title: _notaController.text, idImage: id);

    noteDAO.add(note);

    Navigator.pop(context);
  }

  imageField(context, size) {
    return GestureDetector(
      child: Container(
        height: 250,
        width: size.width - 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: CINZA,
          image: _image != null
              ? DecorationImage(
                  image: FileImage(File(_image!.path)),
                  fit: BoxFit.fill,
                )
              : null,
        ),
      ),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: MARROM,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.camera_alt_outlined),
                                iconSize: 50,
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  // Capture a photo.
                                  final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera,
                                  );

                                  setState(() {
                                    _image = photo;
                                  });
                                },
                              ),
                              Text("Tirar foto"),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.file_open_outlined),
                                iconSize: 50,
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  // Pick an image.
                                  final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  setState(() {
                                    _image = image;
                                  });
                                },
                              ),
                              Text("Escolher arquivo"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
