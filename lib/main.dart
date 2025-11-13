import 'package:flutter/material.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pasta.dart';
import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/views/login.dart';
import 'package:pintassilgo/views/novaPasta.dart';
import 'package:pintassilgo/views/registro.dart';

const AMARELO = Color.fromARGB(255, 255, 213, 42);//"#ffd52a" 

const MARROM = Color.fromARGB(255, 43, 27, 18); // "#2b1b12"
const MARROM_CLARO = Color.fromARGB(255,36, 23, 16); // #24170f

const BRANCO = Color.fromARGB(255, 250, 250, 246); //"#fafaf6"
const CINZA = Color.fromARGB(255, 223, 223, 223);//"#dfdfdf"
const CINZA_ESCURO = Color.fromARGB(255, 110, 110, 110);//"#dfdfdf"

const VERMELHO = Color.fromARGB(255, 232, 65, 42); //#e8412a
void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,

      title: 'Pintassilgo',
      theme: ThemeData(
        colorScheme: ColorScheme(surface: MARROM, primary: BRANCO, secondary: MARROM_CLARO, brightness: Brightness.light, error: VERMELHO, onError: BRANCO, onPrimary: Colors.black, onSecondary: BRANCO, onSurface: BRANCO),
      ),
      home: Login(),
    );
  }
}