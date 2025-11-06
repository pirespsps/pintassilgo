import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 70 / 100,
      width: size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
        ),
        child: Column(
          children: [
            Center(child: Text('registro', style: TextStyle( fontSize: 60, color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.none)),),
            Center(child: TextButton(onPressed: (){}, child: Text('Cadastrar', ))),
            Center(child: TextButton(onPressed: (){}, child: Text('Entrar'))),
          ],
        ),
      ),
    );
  }
}