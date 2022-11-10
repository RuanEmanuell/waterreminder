import "package:flutter/material.dart";

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
          if (value.percentage >= 100 && !value.ok) {
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
        backgroundColor: value.size >= 0.7 ? Colors.blue : Colors.white,
        child: Icon(Icons.add, size: 30, color: value.size >= 0.7 ? Colors.white : Colors.blue));
  }
}
