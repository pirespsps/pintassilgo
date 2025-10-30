import 'package:flutter/material.dart';

const AMARELO = Color.fromARGB(255, 255, 213, 42);//"#ffd52a" 

const MARROM = Color.fromARGB(255, 43, 27, 18); // "#2b1b12"
const MARROM_CLARO = Color.fromARGB(255,36, 23, 16); // #24170f

const BRANCO = Color.fromARGB(255, 248, 248, 248); //"#f8f8f8"
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
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.leave_bags_at_home),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center()
    );
  }
}
