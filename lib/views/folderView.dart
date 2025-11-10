import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pinta.dart';

class FolderView extends StatefulWidget {
  const FolderView({super.key});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Appbar(),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.keyboard_return),
                iconSize: size.width * 10 / 100,
              ),
              Text(
                "Título",
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