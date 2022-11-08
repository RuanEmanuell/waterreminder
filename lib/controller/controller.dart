import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  int percentage = 0;
  double size = 0.8;

  increaseWater() {
    percentage = percentage + 10;
    size = size - 0.1;
    notifyListeners();
  }
}
