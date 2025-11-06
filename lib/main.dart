import 'package:flutter/material.dart';
import 'package:pintassilgo/components/appbar.dart';
import 'package:pintassilgo/components/pasta.dart';

const AMARELO = Color.fromARGB(255, 255, 213, 42);//"#ffd52a" 

const MARROM = Color.fromARGB(255, 43, 27, 18); // "#2b1b12"
const MARROM_CLARO = Color.fromARGB(255,36, 23, 16); // #24170f

const BRANCO = Color.fromARGB(255, 250, 250, 246); //"#fafaf6"
const CINZA = Color.fromARGB(255, 223, 223, 223);//"#dfdfdf"

const VERMELHO = Color.fromARGB(255, 232, 65, 42); //#e8412a
void main() {
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
      home: const MyHomePage(title: 'Pintassilgo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30,0.0,0.0,0.0),
              child: ListView(
                children: [
                  Pasta(),
                  Pasta(),
                  Pasta(),
                  Pasta(),
                  Pasta()
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
