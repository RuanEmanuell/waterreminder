import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';

import "../screens/add.dart";
import "dialog.dart";

class MainButton extends StatelessWidget {
  var value;
  var heroTag;

  MainButton({required this.value, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: heroTag,
        onPressed: () {
          if (value.percentage >= 100 && Hive.box("mensagebox").get("ok") == null) {
            showDialog(
              context: context,
              builder: (context) {
                return WarningDialog(value: value);
              },
            );
          }
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddScreen();
            },
          ));
        },
        backgroundColor: value.darkMode
            ? const Color.fromARGB(255, 0, 84, 153)
            : const Color.fromARGB(255, 94, 94, 94),
        child: const Icon(Icons.add, size: 30, color: Colors.white));
  }
}
