import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pinta.dart';

class FolderView extends StatefulWidget {
  final String nome;
  const FolderView({super.key, required this.nome});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {

  void update() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  widget.nome,
                  style: GoogleFonts.notoSans(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  )
                ),
                IconButton(
                  onPressed: () {},
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
            child: ListView(
              
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Pinta(),
                    Pinta(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Pinta(),
                    Pinta(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Pinta(),
                    Pinta(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Pinta(),
                    Pinta(),
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}