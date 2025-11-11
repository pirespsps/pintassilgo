import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';

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
    if (id == null) {
      return [];
    }
    return await folderDAO.foldersByUser(int.parse(id));
  }
}

class _NovaImagemState extends State<NovaImagem> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _linksController = TextEditingController();

  Future<List<Folder>> get _folders => widget.getFolders();

  Folder? _selectedItem;

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
              Container(
                height: 20,
                decoration: BoxDecoration(
                  //image: DecorationImage(image: Image.file())
                ),
              ),
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
                      text: "nota",
                      fieldController: _notaController,
                      width: size.width - 50,
                      height: 65,
                    ),

                    Field(
                      text: "links",
                      fieldController: _linksController,
                      width: size.width - 50,
                      height: 65,
                    ),

                    Container(
                      width: size.width - 50,
                      decoration: BoxDecoration(
                        color: CINZA,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: FutureBuilder(
                          future: _folders, // Future<List<Folder>>
                          builder: (context, snapshot) {
                            if (snapshot.data!.isEmpty) {
                              return const Text('nenhuma pasta criada');
                            }
                            
                            final folders = snapshot.data!;

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
                              value: _selectedItem,
                              items: folders.map((folder) {
                                return DropdownMenuItem<Folder>(
                                  value: folder,
                                  child: Text(folder.name),
                                );
                              }).toList(),
                              onChanged: (Folder? item) {
                                setState(() {
                                  _selectedItem = item;
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
                  FilledButton(onPressed: () {}, child: Text("cancelar")),
                  FilledButton(onPressed: () {}, child: Text("criar")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

imageField(context, size){
  return GestureDetector(
                child: Container(
                  height: 250,
                  width: size.width - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: CINZA,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.camera_alt_outlined),
                                          iconSize: 50,
                                          onPressed: () {},
                                        ),
                                        Text("Tirar foto"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.file_open_outlined),
                                          iconSize: 50,
                                          onPressed: () {},
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