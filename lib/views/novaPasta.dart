import 'package:flutter/material.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';
import 'package:pintassilgo/models/User/user.dart';

class NovaPasta extends StatefulWidget {
  final User? user;
  const NovaPasta({super.key, this.user});

  @override
  State<NovaPasta> createState() => _NovaPasta();
}

class _NovaPasta extends State<NovaPasta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
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
                "nova pasta",
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
                    onPressed: () {
                      Folder folder = Folder(name: _nomeController.text);
                      folder.idUser = widget.user!.id; //trocar

                      FolderDAO folderdao = FolderDAO();
                      folderdao.add(folder);
                      Navigator.pop(context);
                    },

                    style: FilledButton.styleFrom(
                      backgroundColor: MARROM,
                      foregroundColor: BRANCO,
                    ),
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
}
