import 'dart:collection';

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

    return Container(
     color: colorScheme.secondary ,
     child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(0, 45, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.add_circle_outline_rounded),
              color: colorScheme.onSecondary,
              iconSize: 40,
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: colorScheme.onSecondary
              ),
              child: SizedBox(
                width: 196,
                height: 40,
                child: Form(
                  child: Row(
                    
                  )
                ),
              )
            ),
            SizedBox(
              width: 2,
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.filter_list),
              color: colorScheme.onSecondary,
              iconSize: 40,
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.settings),
              color: colorScheme.onSecondary,
              iconSize: 40,
            ), 
          ],
        ),
      ), 
    );
  }
}