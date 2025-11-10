import 'package:flutter/material.dart';
import 'package:pintassilgo/views/folderView.dart';

class Pasta extends StatefulWidget {
  final String nome;

  const Pasta({super.key, required this.nome});

  @override
  State<Pasta> createState() => _PastaState();
}

class _PastaState extends State<Pasta> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: SizedBox(
        width: size.width * 80 / 100,
        height: size.height * 26 / 100,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return FolderView(nome: widget.nome);
                }));
              }, 
              child: Stack(
                children: [
                  Positioned(
                    left: size.height * 18 / 100,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                    
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.red
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.height * 15 / 100,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.height * 7.5 / 100,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.yellow
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: size.height * 20 / 100,
                      width: size.height * 20 / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: size.width * 80 / 100,
              top: size.height * 20 / 100,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 25.0, 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.nome),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.star)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}