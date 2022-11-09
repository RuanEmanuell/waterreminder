import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  var white = Colors.white;
  var grey = const Color.fromARGB(255, 211, 211, 211);
  var page = 0;

  var button1Color = Colors.white;
  var button2Color = const Color.fromARGB(255, 211, 211, 211);
  var button3Color = const Color.fromARGB(255, 211, 211, 211);

  int percentage = 0;
  double size = 0.82;

  var cups = ["cup", "glass", "big glass", "bottle", "jar", "big bottle"];
  var sizes = ["100ml", "250ml", "400ml", "600ml", "800ml", "1000ml"];

  var history = [];

  changeColor() {
    switch (page) {
      case 0:
        button1Color = white;
        button2Color = grey;
        button3Color = grey;
        break;
      case 1:
        button1Color = grey;
        button2Color = white;
        button3Color = grey;
        break;
      case 2:
        button1Color = grey;
        button2Color = grey;
        button3Color = white;
    }
    notifyListeners();
  }

  addCup() {
    notifyListeners();
  }

  increaseWater() {
    percentage = percentage + 10;
    size = size - 0.1;
    notifyListeners();
  }
}
