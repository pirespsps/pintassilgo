import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pintassilgo/components/field.dart';
import 'package:pintassilgo/components/pasta.dart';
import 'package:pintassilgo/main.dart';
import 'package:pintassilgo/models/Tag/tag.dart';
import 'package:pintassilgo/models/Tag/tagDAO.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class NovaTag extends StatefulWidget {
  final Tag? tag;
  const NovaTag({super.key, this.tag});

  @override
  State<NovaTag> createState() => _NovaTag();
}

class _NovaTag extends State<NovaTag> {
  final _formKey = GlobalKey<FormState>();
  Color selectedColor = Colors.blue;
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nomeController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.tag?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width - 40,
          child: ListView(
            children: [ Container(
              width: size.width - 40,
              height: size.height * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: CINZA,
              ),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      (widget.tag != null?  "editar tag" : "nova tag"),
                      textScaler: TextScaler.linear(3),
                      style: TextStyle(color: MARROM),
                    ),
                    SizedBox(
                      width: size.width - 40,
                      height: size.height * 0.1,
                      child: Field(
                        fieldController: _nomeController,
                        text: "nome",
                        height: 10,
                      ),
                    ),
                    ColorPicker(
            
                    color: selectedColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: MARROM,
                            foregroundColor: BRANCO,
                          ),
                          child: Text("cancelar"),
                        ),
                        FilledButton(
                          onPressed: () async {
                            if (_nomeController.text != "" || _nomeController.text.trim().isNotEmpty){
                              TagDAO tagDAO = TagDAO();
                  
                              if(widget.tag == null){
                  
                                final storage = FlutterSecureStorage();
                  
                                String? id = await storage.read(key: "user");
                  
                                int argb = selectedColor.toARGB32();
                                String hexString = argb.toRadixString(16).padLeft(8, '0');
                                Tag tag = Tag(name: _nomeController.text, color: hexString);
                  
                                tagDAO.add(tag);
                              
                              }else{
                  
                                Tag? tag = await tagDAO.find(widget.tag!.id);
                  
                                tag!.name = _nomeController.text;
                  
                                tagDAO.update(tag, tag.id);
                  
                              }
                  
                              Navigator.pop(context);
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: MARROM,
                            foregroundColor: BRANCO,
                          ),
                          child: widget.tag == null
                          ?Text("criar")
                          :Text("salvar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
