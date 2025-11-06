import 'package:flutter/material.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';

class NovaImagem extends StatefulWidget {
  const NovaImagem({super.key});

  @override
  State<NovaImagem> createState() => _NovaImagemState();
}

class _NovaImagemState extends State<NovaImagem> {

  @override
  Widget build(BuildContext context) {

  Size size = MediaQuery.of(context).size;
    final _formkey = GlobalKey<FormState>();
    final TextEditingController _tituloController = TextEditingController();
    final TextEditingController _notaController = TextEditingController();
    final TextEditingController _linksController = TextEditingController();

    return Container(
      color: MARROM_CLARO,
      width: size.width,
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 5),
        child: Column(
          children: [
            Text("nova foto",  style: TextStyle(
              color: Colors.white,
            ),),
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
            ),
            
            Field(
              formKey: _formkey,
              text: "nota",
              fieldController: _notaController,
            ),
            
            Field(
              formKey: _formkey,
              text: "links",
              fieldController: _linksController,
            ),
          ],
        ),
      ),
    );
  }
}