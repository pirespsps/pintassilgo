import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/components/pasta.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';
import 'package:pintassilgo/models/User/user.dart';

class NovaPasta extends StatefulWidget {
  final Folder? folder;
  const NovaPasta({super.key, this.folder});

  @override
  State<NovaPasta> createState() => _NovaPasta();
}

class _NovaPasta extends State<NovaPasta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nomeController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.folder?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          width: size.width - 40,
          height: size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: CINZA,
          ),
          child: Column(
            spacing: 10,
            children: [
              Text(
                (widget.folder == null?  "nova pasta" : "editar pasta"),
                textScaler: TextScaler.linear(4),
                style: TextStyle(color: MARROM),
              ),
              Field(
                fieldController: _nomeController,
                text: "nome",
                height: 100,
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: MARROM,
                      foregroundColor: BRANCO,
                    ),
                    child: Text("cancelar"),
                  ),
                  FilledButton(
                    onPressed: () async {

                      FolderDAO folderDAO = FolderDAO();

                      if(widget.folder == null){

                        final storage = FlutterSecureStorage();

                        String? id = await storage.read(key: "user");

                        Folder folder = Folder(name: _nomeController.text);
                        folder.idUser = int.parse(id!);

                        folderDAO.add(folder);
                      
                      }else{

                        Folder? pasta = await folderDAO.find(widget.folder!.id);

                        pasta!.name = _nomeController.text;

                        folderDAO.update(pasta, pasta.id);

                      }

                      Navigator.pop(context);
                    },

                    style: FilledButton.styleFrom(
                      backgroundColor: MARROM,
                      foregroundColor: BRANCO,
                    ),
                    child: widget.folder == null
                    ?Text("criar")
                    :Text("salvar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
