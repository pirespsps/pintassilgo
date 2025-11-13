import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pinta.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Folder/folderDAO.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/Image/imageDAO.dart';
import 'package:pintassilgo/models/Note/noteDAO.dart';
import 'package:pintassilgo/models/Tag/tag.dart';
import 'package:pintassilgo/models/Tag/tagDAO.dart';
import 'package:pintassilgo/views/home.dart';
import 'package:pintassilgo/views/novaPasta.dart';

class FolderView extends StatefulWidget {
  final Folder folder;
  const FolderView({super.key, required this.folder});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  void update() {
    setState(() {});
  }

  ImageDAO imageDao = ImageDAO();
  TagDAO tagDAO = TagDAO();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    FolderDAO folderDao = FolderDAO();

    Future<List<Imagem>> images = imageDao.imagesByFolder(
      widget.folder.id!,
      50,
    );

    Future<List<Tag>> tags = tagDAO.tagsByFolder(widget.folder.id!);

    setState(() {});

    return Scaffold(
      body: Column(
        children: [
          Appbar(updateParent: update),
          SizedBox(
            width: size.width,
            child: Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,

              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_return),
                  iconSize: size.width * 10 / 100,
                ),
                Text(
                  widget.folder.name,
                  style: GoogleFonts.notoSans(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return NovaPasta(folder: widget.folder);
                        },
                      ),
                    );

                    setState(() {});
                  },
                  icon: Icon(Icons.edit),
                  iconSize: size.width * 10 / 100,
                ),
                IconButton(
                  onPressed: () async {
                    showDialog<String>(
                      context: context,
                      builder: (context) =>
                          getDialog(context, widget.folder.id!),
                    );
                    setState(() {});
                  },
                  icon: Icon(Icons.delete),
                  iconSize: size.width * 10 / 100,
                ),
                IconButton(
                  onPressed: () async {
                      widget.folder.like();
                      await folderDao.update(widget.folder, widget.folder.id!);
                      
                      setState(() {
                      });
                  },
                  icon: widget.folder.isLiked ? Icon(Icons.star) : Icon(Icons.star_border),
                  iconSize: size.width * 10 / 100,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: tags,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            snapshot.data![index].name,
                            style: TextStyle(
                              //backgroundColor: Color.fromARGB(snapshot.data[index].color), muda cor aq!
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Text("Sem tags para a pasta!");
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: images,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  double index =
                      ((snapshot.data!.length / 2) * 10 +
                          (((snapshot.data!.length / 2) * 10) % 10 * 2)) /
                      10;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Pinta(imagem: snapshot.data![index * 2]),
                          index * 2 + 1 < snapshot.data!.length
                              ? Pinta(imagem: snapshot.data![index * 2 + 1])
                              : Container(width: size.width * 40 / 100),
                        ],
                      );
                    },

                    itemCount: int.parse("${index}".split(".")[0]),
                  );
                } else {
                  return Text("Não há nenhuma imagem nessa pasta!");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Dialog getDialog(context, int id) {
  return Dialog(
    child: Padding(
      padding: EdgeInsetsGeometry.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("você deseja mesmo deletar a pasta?"),
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
                  ImageDAO imagedao = ImageDAO();
                  List<Imagem> images = await imagedao.imagesByFolder(id, null);

                  final Directory dir =
                      await getApplicationDocumentsDirectory();
                  final String path = join(dir.path, "images/");

                  for (int i = 0; i < images.length; i++) {
                    final File file = File(
                      join(path, "${images.elementAt(i).id}.png"),
                    );
                    await file.delete();
                  }

                  FolderDAO folderDAO = FolderDAO();
                  folderDAO.remove(id);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MyHomePage();
                      },
                    ),
                  );
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

/*
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Pinta(),
    Pinta(),
  ],
),
*/
