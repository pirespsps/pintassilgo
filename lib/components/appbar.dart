
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pintassilgo/views/configView.dart';
import 'package:pintassilgo/views/novaImagem.dart';
import 'package:pintassilgo/views/novaPasta.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key, required this.updateParent});

  final Function updateParent;

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  bool isFocused = false;

  OverlayEntry? _overlayAdd;

  void removeOverlayAdd() {
    _overlayAdd!.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Container(

           color: colorScheme.secondary ,
           child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 45, 10, 0),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      _overlayAdd = OverlayEntry(
                        builder: (BuildContext context) {
                          ColorScheme colorScheme = Theme.of(context).colorScheme;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(120, 0, 0, 0)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0.0, size.height * 0.1, 0.0, size.height * 0.1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colorScheme.surface
                                        ),
                                        child: Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                removeOverlayAdd();
                                              },
                                              icon: Icon(Icons.close),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                removeOverlayAdd();
                                                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                                  return NovaImagem();
                                                }));

                                                widget.updateParent();
                                              }, 
                                              child: Text("Enviar nova imagem")
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                removeOverlayAdd();
                                                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                                  return NovaPasta();
                                                }));

                                                widget.updateParent();
                                              }, 
                                              child: Text("Criar nova pasta")
                                            )
                                          ],
                                        )
                                      ),
                                    ),
                                  ),
                                )
                              )
                            ],
                          );
                        }
                      );
                      Overlay.of(context, debugRequiredFor: widget).insert(
                        _overlayAdd!
                      );
                      RenderPerformanceOverlay();
                    },
                    icon: Icon(Icons.add_circle_outline_rounded),
                    color: colorScheme.onSecondary,
                    iconSize: size.width * 10 / 100,
                  ),
                  Positioned(
                    left: size.width * 15 / 100,
                    top: size.width * 1.75 / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: colorScheme.onSecondary
                      ),
                      child: AnimatedSize(
                        duration: Duration(microseconds: 100000),
                        curve: Curves.linear,
                        child: SizedBox(
                          width: isFocused ? size.width * 80 / 100 : size.width * 50 / 100,
                          height: 40,
                          child: Form(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                      color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 9.0),
                                      border: InputBorder.none
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isFocused = true;
                                      });
                                    },
                                    onTapOutside: (coisa) {
                                      setState(() {
                                        isFocused = false;
                                        FocusScope.of(context).unfocus();
                                      });
                                    },
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                      )
                    ), 
                  ),
                  Positioned(
                    left: size.width * 70 / 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.filter_list),
                          color: colorScheme.onSecondary,
                          iconSize: size.width * 10 / 100,
                        ),
                        IconButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return Config();
                            }))
                          },
                          icon: Icon(Icons.settings),
                          color: colorScheme.onSecondary,
                          iconSize: size.width * 10 / 100,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ), 
          ),
        ),
      ],
    );
  }
}