import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  var white = Colors.white;
  var grey = const Color.fromARGB(255, 211, 211, 211);
  var page = 0;

  var button1Color = Colors.white;
  var button2Color = const Color.fromARGB(255, 211, 211, 211);
  var button3Color = const Color.fromARGB(255, 211, 211, 211);

  late int cupSize;
  double percentage = 0;
  double size = 0.82;
  bool ok = false;

  var cups = [
    ["cup", "glass", "big glass", "bottle", "jar", "big bottle"],
    ["100", "250", "400", "600", "800", "1000"]
  ];

  var history = [[], [], []];

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
    percentage = percentage + cupSize / 20;
    percentage <= 100 ? size = size - cupSize / 2000 : size = -0.2;
    notifyListeners();
  }
}
