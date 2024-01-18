import 'package:water_reminder/controller/controller.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../models/languages.dart';

class WarningDialog extends StatelessWidget {
  final Controller value;

  const WarningDialog({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: value.darkMode ? const Color.fromARGB(255, 29, 29, 29) : Colors.white,
        content: Text(value.english ? english[9] : portuguese[9],
            style: TextStyle(
              color: value.darkMode ? Colors.white : Colors.black,
            )),
        actions: [
          TextButton(
              onPressed: () {
                value.okFunction();
                Navigator.pop(context);
              },
              child: Text("Ok", style: TextStyle(color: value.darkMode ? Colors.white : Colors.black)))
        ]);
  }
}

class CustomDialog extends StatelessWidget {
  final TextEditingController textController;
  final Controller value;

  const CustomDialog({super.key, required this.textController, required this.value});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: value.darkMode ? const Color.fromARGB(255, 29, 29, 29) : Colors.white,
        content: Text(value.english ? english[8] : portuguese[8],
            style: TextStyle(color: value.darkMode ? Colors.white : Colors.black)),
        actions: [
          TextField(
              maxLength: 4,
              controller: textController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(color: value.darkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: value.darkMode ? Colors.white : Colors.black)))),
          TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  value.isCustom = true;
                  value.text = textController.text;
                  value.addCup();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Text("Ok", style: TextStyle(color: value.darkMode ? Colors.white : Colors.black)))
        ]);
  }
}
