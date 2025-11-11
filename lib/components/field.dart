import 'package:flutter/material.dart';
import 'package:pintassilgo/main.dart';

class Field extends StatefulWidget {
  final TextEditingController fieldController;
  final String text;
  final double? height;
  final double? width;
  final Function? validator;

  const Field({
    super.key,
    required this.fieldController,
    required this.text,
    this.validator,
    this.height,
    this.width,
  });

  @override
  State<Field> createState() => _FieldFormState();
}

class _FieldFormState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 50,
      width: widget.width ?? 300,
      decoration: BoxDecoration(
        color: CINZA,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.text,
              style: TextStyle(color: MARROM),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToLastDescent: false,
              ),
            ),
          ),
          SizedBox(
            height: (widget.height! * 0.6),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: widget.fieldController,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                cursorHeight: 15,
                validator: widget.validator != null
                ? widget.validator!() 
                : (value){
                  if(value == null || value.isEmpty){
                    return "Entre com um texto válido";
                  }
                  return null;
                },
                
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: CINZA_ESCURO)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: CINZA_ESCURO)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
