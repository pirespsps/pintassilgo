import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/dataBaseHelper.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/views/login.dart';
import 'package:sqflite/sqlite_api.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: MARROM),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, size: 30, color: BRANCO),
                  ),
                ],
              ),
              ConfigOption(
                opcao: "Resetar database",
                onPressed: () async {
                  await DatabaseHelper.instance.resetDatabase();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Login();
                      },
                    ),
                  );
                },
                textoBT: "Resetar",
              ),
              ConfigOption(
                opcao: "Logout",
                onPressed: () {
                  FlutterSecureStorage storage = FlutterSecureStorage();
                  storage.delete(key: "user");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Login();
                      },
                    ),
                  );
                },
                textoBT: "Sair",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfigOption extends StatefulWidget {
  final String opcao;
  final String textoBT;
  final VoidCallback onPressed;
  const ConfigOption({
    super.key,
    required this.opcao,
    required this.onPressed,
    required this.textoBT,
  });

  @override
  State<ConfigOption> createState() => _ConfigOptionState();
}

class _ConfigOptionState extends State<ConfigOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.opcao),
        TextButton(onPressed: widget.onPressed, child: Text(widget.textoBT)),
      ],
    );
  }
}
