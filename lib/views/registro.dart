import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/models/User/userDAO.dart';
import 'package:pintassilgo/views/home.dart';
import 'package:pintassilgo/views/login.dart';

class Registro extends StatefulWidget {
  final User? user;
  const Registro({super.key, this.user});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();
  final dao = UserDAO();
  bool _visibilidadeSenha = false;
  bool _visibilidadeConfirmarSenha = false;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height * 25 / 100,
              width: size.width,
              child: Center(child: Image(image: AssetImage('images/icon.jpg'))),
            ),
            SizedBox(
              height: size.height * 75 / 100,
              width: size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      SizedBox(height: size.height * 2 / 100),
                      Text(
                        'registro',
                        style: TextStyle(
                          fontSize: 55,
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: size.height * 2 / 100),
                      Field(
                        text: "usuário",
                        fieldController: _nomeController,
                        width: size.width - 50,
                        height: size.height * 5 / 100,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'este campo é obrigatório';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Field(
                        text: "senha",
                        fieldController: _senhaController,
        
                        width: size.width - 50,
                        height: size.height * 5 / 100,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'este campo é obrigatório';
                          }else if(value.length < 6){
                            return 'a senha deve ter no mínimo 6 caracteres';
                          } else {
                            return null;
                          }
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibilidadeSenha ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).colorScheme.onPrimary) ,
                          onPressed: (){
                            setState(() {
                              _visibilidadeSenha = !_visibilidadeSenha;
                            });
                          }, 
                          ),
                        obscureText: !_visibilidadeSenha,
                      ),
        
                      Field(
                        text: "confirme sua senha",
                        fieldController: _confirmarSenhaController,
        
                        width: size.width - 50,
                        height: size.height * 5 / 100,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'este campo é obrigatório';
                            }else if(value != _senhaController.text){
                              return 'este campo não corresponde à senha';
                          } else {
                            return null;
                          }
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibilidadeConfirmarSenha ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).colorScheme.onPrimary) ,
                          onPressed: (){
                            setState(() {
                              _visibilidadeConfirmarSenha = !_visibilidadeConfirmarSenha;
                            });
                          }, 
                          ),
                        obscureText: !_visibilidadeConfirmarSenha,
                      ),
        
                      SizedBox(height: size.height * 1 / 100),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            child: Text(
                              "cadastrar",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              setState(() {
                                
                              });
                              if (_formKey.currentState!.validate()){
                                dao.registro(User(name: _nomeController.text, password: _senhaController.text))
                                .whenComplete((){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),);
                                });
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: TextButton(
                              child: Text(
                                "entrar (já tenho uma conta)",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
