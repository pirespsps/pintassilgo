import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/views/folderView.dart';

class Pasta extends StatefulWidget {
  final String nome;
  final Folder pasta;
  final Function updateParent;

  const Pasta({super.key, required this.nome, required this.pasta, required this.updateParent});

  @override
  State<Pasta> createState() => _PastaState();
}

class _PastaState extends State<Pasta> {

  Future<Directory> documentsDirectory = getApplicationDocumentsDirectory();

  FolderDAO folderDao = FolderDAO();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: SizedBox(
        width: size.width * 80 / 100,
        height: size.height * 26 / 100,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return FolderView(folder: widget.pasta);
                }));

                setState(() {
                  
                });

                widget.updateParent();
              }, 
              child: Stack(
                children: [
                  for (int i = 0; i < (widget.pasta.images != null ? widget.pasta.images!.length : 0); i++) FutureBuilder(
                    future: documentsDirectory,
                    builder: (context, asyncSnapshot) {
                      return Positioned(
                        left: size.height * (i == 0 ? 18 : i == 1 ? 15 : i == 2 ? 7.5 : 0) / 100,
                        child: Container(
                          height: size.height * 20 / 100,
                          width: size.height * 20 / 100,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: asyncSnapshot.data != null ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(
                                  join(
                                    asyncSnapshot.data!.path,
                                    "images/",
                                    widget.pasta.images![i].id!.toString() + ".png",
                                  ),
                                )
                              )
                            ) : null
                          ),
                        ),
                      );
                    }
                  ),
                  widget.pasta.images!.length != 0 ? Container() : Positioned(
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 80 / 100,
                    
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              width: size.width * 80 / 100,
              top: size.height * 20 / 100,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 25.0, 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.nome),
                    IconButton(
                      onPressed: () async {
                        widget.pasta.like();
                        await folderDao.update(widget.pasta, widget.pasta.id!);
                        
                        setState(() {
                        });
                      },
                      icon: widget.pasta.isLiked ? Icon(Icons.star) : Icon(Icons.star_border)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
                  Positioned(
                    left: size.height * 18 / 100,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                    
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.red
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.height * 15 / 100,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.height * 7.5 / 100,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.yellow
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.green
                      ),
                    ),
                  ),
*/