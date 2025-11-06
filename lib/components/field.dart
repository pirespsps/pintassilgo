import 'package:flutter/material.dart';
import 'package:pintassilgo/main.dart';

class Field extends StatefulWidget {
  
  final GlobalKey<FormState> formKey;
  final TextEditingController fieldController;
  final String text;
  final double ?height;
  final double ?width;

  const Field({super.key,required this.formKey, required this.fieldController, required this.text, this.height, this.width});

  @override
  State<Field> createState() => _FieldFormState();
}

class _FieldFormState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CINZA,
      height: widget.height ?? 50,
      width: widget.width ?? 100,
      child: Column(
        children: [
          Text(widget.text, style: TextStyle(
            color: MARROM
          ),),
          Container(
            height: widget.height != null? widget.height!/2.5 : 35,
          ),
          TextField(key: widget.key, controller: widget.fieldController,)
        ],
      ),
    );
  }
}