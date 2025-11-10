import 'package:flutter/material.dart';

class Pinta extends StatelessWidget {
  const Pinta({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 40 / 100,
      height: size.width * 60 / 100,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: size.width * 40 / 100,
              height: size.width * 40 / 100,
            
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
            child: Text(
              "Pinta 1",
              style: TextStyle(
                fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }
}