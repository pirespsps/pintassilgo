import 'package:flutter/material.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pasta.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        children: [
          Appbar(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Pasta(nome: "Cogumelos",),
                ),
                Center(
                  child: Pasta(nome: "Aves"),
                ),
                Center(
                  child: Pasta(nome: "Animais silvestres"),
                ),
                Center(
                  child: Pasta(nome: "Slime molds"),
                ),
              ],
            ),
          )
        ],
      )
    );
  } // 190205
}