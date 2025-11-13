import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/models/User/userDAO.dart';
import 'package:pintassilgo/views/home.dart';
import 'package:pintassilgo/views/registro.dart';
import 'package:pintassilgo/dataBaseHelper.dart';

class Login extends StatefulWidget {
  final User? user;
  const Login({super.key, this.user});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final dao = UserDAO();
  String _user = '', _senha = '';
  bool _isLoginErrado = false;
  bool _visibilidadeSenha = false;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  login() async {
    var resposta = await dao.login(User(name: _user, password: _senha));
    if (resposta == true){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );      
    }else{
      _isLoginErrado = true;
      setState(() {
      });
    }
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    SizedBox(
                      height: size.width * 10/100,
                    ),
                    Text('login', style: TextStyle( fontSize: 50, color: Theme.of(context).colorScheme.onPrimary, decoration: TextDecoration.none)),
                    _isLoginErrado? Text(
                        "usuário ou senha incorretos",
                        style: TextStyle(color: Colors.red)
                      ) : SizedBox(),
                    SizedBox(
                      height: size.width * 7/100,
                    ),
                    Field(
                      text: "usuário",
                      fieldController: _nomeController,
                      width: size.width - 50,
                      height: 50,
                      validator: (value){
                        if(value == null || value.trim().isEmpty ){
                          return 'este campo é obrigatório';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (value) => _user = value.toString(),
                    ),
                    Field(
                      text: "senha",
                      fieldController: _senhaController,
                      width: size.width - 50,
                      height: 50,
                      validator: (value){
                        if(value == null || value.trim().isEmpty ){
                          return 'este campo é obrigatório';
                        }else if(value.length < 6){
                          return 'a senha deve ter no mínimo 6 caracteres';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (value) => _senha = value.toString(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            _visibilidadeSenha ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).colorScheme.onPrimary) ,
                          onPressed: (){
                            setState(() {
                              _visibilidadeSenha = !_visibilidadeSenha;
                            });
                          }, 
                          ),
                      ),
                      obscureText: !_visibilidadeSenha,
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
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            setState(() {});
                          if (_formKey.currentState!.validate()){
                            login();
                          }   
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextButton(
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