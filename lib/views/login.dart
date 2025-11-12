import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/models/User/userDAO.dart';
import 'package:pintassilgo/views/home.dart';
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height * 25 / 100,
              width: size.width,
              child: Center(
                child: Image(image: AssetImage('images/icon.jpg'),),
              ),
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
                    spacing: 15,
                    children: [
                      SizedBox(
                        height: size.width * 10/100,
                      ),
                      Text('login', style: TextStyle( fontSize: 60, color: Theme.of(context).colorScheme.onPrimary, decoration: TextDecoration.none)),
                      SizedBox(
                        height: size.width * 10/100,
                      ),
                      Field(
                        text: "usuario",
                        fieldController: _nomeController,
                        width: size.width - 50,
                        height: 65,
                        validator: (value){
                          if(value == null || value.isEmpty ){
                            return 'este campo é obrigatório';
                          // }else if(value != TODOS OS USUARIOS CADASTRADOS){
                          //   // usuario n corresponde
                          //   return 'este usuário não existe';
                          }else{
                            return null;
                          }
                        },
                      ),
                      Field(
                        text: "senha",
                        fieldController: _senhaController,
                        
                        width: size.width - 50,
                        height: 65,
                        validator: (value){
                          if(value == null || value.isEmpty ){
                            return 'este campo é obrigatório';
                          // }else if(value != senha do usuario digitado){
                          //   // compara com a senha
                          //   return 'senha incorreta';
                          }else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: size.width * 10/100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary)
                            ),
                            child: Text("entrar",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () async {
                              //entrar no site
                              
                              UserDAO userDAO = UserDAO();
                              User? user = await userDAO.getByNameAndPassword(_nomeController.text, _senhaController.text);
        
                              if(user == null){
                                //nome ou senha incorretos
                              }
        
                              final storage = FlutterSecureStorage();
                              storage.write(key: "user", value: user!.id.toString());
        
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyHomePage()),
                              );
                            },
                          ),
                          TextButton(
                            child: Text("criar uma conta",
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onPrimary
                              ),
                            ),
                            onPressed: () async {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Registro(),),);
                            },
                          ),
                        ],
                      )
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