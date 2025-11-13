import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pinta.dart';
import 'package:pintassilgo/models/Folder/folder.dart';
import 'package:pintassilgo/models/Image/image.dart';
import 'package:pintassilgo/models/Image/imageDAO.dart';
import 'package:pintassilgo/views/novaPasta.dart';

class FolderView extends StatefulWidget {
  final Folder folder;
  const FolderView({super.key, required this.folder});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {

  void update() {
    setState(() {
      
    });
  }

  ImageDAO imageDao = ImageDAO();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<List<Imagem>> images = imageDao.imagesByFolder(widget.folder.id!, 50); 

    return Scaffold(
      body: Column(
        children: [
          Appbar(updateParent: update,),
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
                    fontWeight: FontWeight.bold
                  )
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                      return NovaPasta(folder: widget.folder);
                    }));
                    
                    setState(() {
                      
                    });

                  },
                  icon: Icon(Icons.edit),
                  iconSize: size.width * 10 / 100,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.star),iconSize: size.width * 10 / 100,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: images, 
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  double index = ((snapshot.data!.length / 2) * 10 + (((snapshot.data!.length / 2) * 10) % 10 * 2)) / 10;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Pinta(imagem: snapshot.data![index*2]),
                          index*2 + 1 < snapshot.data!.length ? Pinta(imagem: snapshot.data![index*2 + 1]) : Container( width: size.width * 40 / 100,),
                        ],
                      );
                    },

                    itemCount: int.parse("${index}".split(".")[0]),
                  );
                } else {
                  return Text("Não há nenhuma imagem nessa pasta!");
                }
              },
            )
          )
        ],
      ),
    );
  }
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