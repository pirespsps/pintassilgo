import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pasta.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FlutterSecureStorage storage = FlutterSecureStorage();

  FolderDAO folderDao = FolderDAO();

  bool updated = false;

  void update() {
    setState(() {
      updated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> id = storage.read(key: "user");

    return Scaffold(
      body: Column(
        children: [
          Appbar(updateParent: update,),
          FutureBuilder(
            future: id,
            builder: (context, snapshot) {

              var userId = snapshot.data;

              if (userId != null) {

                Future<List<Folder>> folders = folderDao.foldersByUser(int.parse(userId));

                return FutureBuilder(
                  future: folders, 
                  builder: (context, snapshot) {
                    var folderList = snapshot.data;

                    if (folderList != null){
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Center(
                              child: Pasta(
                                nome: folderList[index].name
                              ),
                            );
                          },
                          itemCount: folderList.length,
                        ),
                      );
                    } else {
                      return Text("Ainda não há pastas!");
                    }
                  },
                );
              } else {
                return Text("Espera-lá");
              }
            },
          ),
        ],
      )
    );
  } // 190205
}