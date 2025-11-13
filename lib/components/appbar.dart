
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pintassilgo/models/Tag/tag.dart';
import 'package:pintassilgo/models/Tag/tagDAO.dart';
import 'package:pintassilgo/views/configView.dart';
import 'package:pintassilgo/views/novaImagem.dart';
import 'package:pintassilgo/views/novaPasta.dart';
import 'package:pintassilgo/views/novaTag.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key, required this.updateParent});

  final Function updateParent;

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  bool isFocused = false;

  OverlayEntry? _overlayAdd;
  OverlayEntry? _overlayFiltro;

  void removeOverlayAdd() {
    _overlayAdd!.remove();
  }

  void removeOverlayFiltro() {
    _overlayFiltro!.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    TagDAO tagDao = TagDAO();

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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(120, 0, 0, 0)
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: size.height * 50 / 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0.0, size.height * 0.1, 0.0, size.height * 0.1),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
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
                                                child: Text("enviar nova imagem")
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  removeOverlayAdd();
                                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                                    return NovaPasta();
                                                  }));
                                      
                                                  widget.updateParent();
                                                }, 
                                                child: Text("criar nova pasta")
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  removeOverlayAdd();
                                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                                    return NovaTag();
                                                  }));
                                      
                                                  widget.updateParent();
                                                }, 
                                                child: Text("criar nova tag")
                                              ),
                                            ],
                                          )
                                        ),
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
                          onPressed: () {
                            _overlayFiltro = OverlayEntry(
                              builder: (BuildContext context) {
                                ColorScheme colorScheme = Theme.of(context).colorScheme;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(120, 0, 0, 0)
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width: size.width * 80 / 100,
                                            height: size.height * 80 / 100,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, size.height * 0.1, 0.0, size.height * 0.1),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: colorScheme.surface
                                                ),
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        removeOverlayFiltro();
                                                      },
                                                      icon: Icon(Icons.close),
                                                    ),

                                                    FutureBuilder(
                                                      future: tagDao.list(), 
                                                      builder: (context, snapshot) {
                                                        if (snapshot.data != null) {
                                                          return SizedBox(
                                                            width: size.width * 75 / 100,
                                                            height: size.height * 50 / 100,
                                                            child: ListView.builder(
                                                              itemCount: snapshot.data!.length,
                                                              itemBuilder: (context, index) {
                                                                return Container(
                                                                  width: size.width * 75 / 100,
                                                                  height: size.height * 10 / 100,
                                                                  decoration: BoxDecoration(
                                                                    color: snapshot.data![index].color.toColor
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed: () {},
                                                                        icon: Icon(Icons.circle_outlined)
                                                                      ),
                                                                      Material(
                                                                        color: Colors.transparent,
                                                                        child: Text(
                                                                          snapshot.data![index].name,
                                                                        
                                                                          style: TextStyle(
                                                                            color: Colors.white,
                                                                            textBaseline: null,
                                                                            fontSize: 15
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              }
                                                            ),
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      }
                                                    )
                                                  ],
                                                )
                                              ),
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
                              _overlayFiltro!
                            );
                            RenderPerformanceOverlay();
                          },
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