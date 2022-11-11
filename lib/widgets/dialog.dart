import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../models/languages.dart';

class WarningDialog extends StatelessWidget {
  var value;

  WarningDialog({required this.value});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text(
          value.english ? english[9] : portuguese[9],
        ),
        actions: [
          TextButton(
              onPressed: () {
                value.ok = true;
                Navigator.pop(context);
              },
              child: const Text("Ok"))
        ]);
  }
}

class CustomDialog extends StatelessWidget {
  var textController;
  var value;

  CustomDialog({required this.textController, required this.value});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(content: Text(value.english ? english[8] : portuguese[8]), actions: [
      TextField(
          maxLength: 4,
          controller: textController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
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
          child: const Text("Ok"))
    ]);
  }
}
