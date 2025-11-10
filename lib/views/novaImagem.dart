import 'package:flutter/material.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';

class NovaImagem extends StatefulWidget {
  const NovaImagem({super.key});

  @override
  State<NovaImagem> createState() => _NovaImagemState();
}

class _NovaImagemState extends State<NovaImagem> {
  
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _linksController = TextEditingController();

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

              Field(
                formKey: _formkey,
                text: "título",
                fieldController: _tituloController,
                width: size.width - 50,
                height: 65,
              ),

              Field(
                formKey: _formkey,
                text: "nota",
                fieldController: _notaController,
                width: size.width - 50,
                height: 65,
              ),

              Field(
                formKey: _formkey,
                text: "links",
                fieldController: _linksController,
                width: size.width - 50,
                height: 65,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
