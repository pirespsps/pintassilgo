import 'package:flutter/material.dart';
import 'package:pintassilgo/main.dart';

class Field extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fieldController;
  final String text;
  final double? height;
  final double? width;

  const Field({
    super.key,
    required this.formKey,
    required this.fieldController,
    required this.text,
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
              child: TextField(
                controller: widget.fieldController,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                cursorHeight: 15,
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
