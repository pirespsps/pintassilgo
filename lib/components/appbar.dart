
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: Container(

           color: colorScheme.secondary ,
           child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 45, 10, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.add_circle_outline_rounded),
                    color: colorScheme.onSecondary,
                    iconSize: size.width * 10 / 100,
                  ),
                  SizedBox(
                    width: size.width * 2 / 100,
                  ),
                  Container(
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
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 1 / 100,
                        ),
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.filter_list),
                          color: colorScheme.onSecondary,
                          iconSize: size.width * 10 / 100,
                        ),
                        IconButton(
                          onPressed: () => {},
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