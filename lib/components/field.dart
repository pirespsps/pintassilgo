import 'package:flutter/material.dart';
import 'package:pintassilgo/main.dart';

class Field extends StatefulWidget {
  final TextEditingController fieldController;
  final String text;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? initialValue;

  const Field({
    super.key,
    required this.fieldController,
    required this.text,
    this.validator,
    this.height,
    this.width,
    this.onSaved,
    this.suffixIcon,
    this.obscureText,
    this.initialValue
  });

  @override
  State<Field> createState() => _FieldFormState();
}

class _FieldFormState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
              height: widget.height == null? (widget.height! * 0.6) : 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: widget.fieldController,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  cursorHeight: 15,
                  validator: widget.validator ?? 
                  (value){
                    if(value == null || value.isEmpty){
                      return "Entre com um texto válido";
                    }
                    return null;
                  },
                  onSaved: widget.onSaved ??
                  (value){},
                  
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: CINZA_ESCURO)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: CINZA_ESCURO)),
                    suffixIcon: widget.suffixIcon ??
                    SizedBox(width: 0, height: 0,),
                  ),
      
                  obscureText: widget.obscureText ??
                  false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
