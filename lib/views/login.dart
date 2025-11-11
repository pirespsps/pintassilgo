import 'package:flutter/material.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/views/registro.dart';

class Login extends StatefulWidget {
  final User? user;
  const Login({super.key, this.user});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose(){
    _nomeController.dispose();
    _senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Center(child: Text('login', style: TextStyle( fontSize: 60, color: Theme.of(context).colorScheme.primary, decoration: TextDecoration.none)),),
                Center(
                  child: Field(
                    text: "usuario",
                    fieldController: _nomeController,
                    width: size.width - 50,
                    height: 65,
                    validator: (value){
                      if(value == null || value.isEmpty ){
                        return 'este campo é obrigatório';
                      // }else if(){
                      //   // usuario n corresponde
                      //   return 'este usuário não existe';
                      }else{
                        return null;
                      }
                    },
                    ),
                ),
              Center(
                child: Field(
                  text: "senha",
                  fieldController: _senhaController,
                  width: size.width - 50,
                  height: 65,
                  validator: (value){
                    if(value == null || value.isEmpty ){
                      return 'este campo é obrigatório';
                    // }else if(){
                    //   // compara com a senha
                    //   return 'senha incorreta';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary)
                  ),
                  child: Text("entrar)",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () async {
                    //entrar no site
                  },
                ),
              ),
              Center(
                child: TextButton(
                  child: Text("criar uma conta",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Registro(),),);
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