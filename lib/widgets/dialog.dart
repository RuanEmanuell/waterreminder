import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class WarningDialog extends StatelessWidget {
  var value;

  WarningDialog({required this.value});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: const Text(
            "You've already hit the official goal of 2 liters of water per day from the World Health Organization, but we will continue to monitor! Let's drink water!"),
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
    return AlertDialog(content: const Text("Add other size (ml)"), actions: [
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
