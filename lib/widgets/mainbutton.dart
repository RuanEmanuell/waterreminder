import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';

import "../screens/add.dart";
import "dialog.dart";

class MainButton extends StatelessWidget {
  var value;
  var heroTag;
  var icon;
  var onPressed;

  MainButton({required this.value, required this.heroTag, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: value.darkMode
            ? const Color.fromARGB(255, 0, 84, 153)
            : const Color.fromARGB(255, 94, 94, 94),
        child: Icon(icon, size: 30, color: Colors.white));
  }
}
