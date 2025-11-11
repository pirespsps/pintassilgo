import 'package:flutter/material.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/models/User/user.dart';

class Registro extends StatefulWidget {
  final User? user;
  const Registro({super.key, this.user});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  @override
  void initState(){
    super.initState();
    //NAO SEI O QUE FAZER
  }

  @override
  void dispose(){
    _nomeController.dispose();
    _senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 15 / 100,
          width: size.width,
          child: Center(
            child: Image(image: AssetImage('images/icon.jpg'),),
          ),
        ),
        SizedBox(
          height: size.height * 85 / 100,
          width: size.width,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
            ),
            child: Column(
              children: [
                Center(child: Text('registro', style: TextStyle( fontSize: 60, color: Theme.of(context).colorScheme.primary, decoration: TextDecoration.none)),),
                Center(
                  child: Field(
                    formKey: _formKey,
                    text: "usuario",
                    fieldController: _nomeController,
                    width: size.width - 50,
                    height: 65,
                                ),
                ),
              Center(
                child: Field(
                    formKey: _formKey,
                    text: "senha",
                    fieldController: _senhaController,
                    width: size.width - 50,
                    height: 65,
                ),
              ),
              Center(
                child: Field(
                    formKey: _formKey,
                    text: "confirme sua senha",
                    fieldController: _confirmarSenhaController,
                    width: size.width - 50,
                    height: 65,
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary)
                  ),
                  child: Text("cadastrar)",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () async {
                  },
                ),
              ),
              Center(
                child: TextButton(
                  child: Text("entrar (já tenho conta)",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                  },
                ),
              )
              ],
            ),
          ),
        ),
      ],
    );
  }
}