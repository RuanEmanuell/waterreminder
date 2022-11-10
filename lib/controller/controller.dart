import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  var index;
  double text = 0;
  bool isCustom = false;

  var white = Colors.white;
  var grey = const Color.fromARGB(255, 211, 211, 211);
  var page = 0;

  var button1Color = Colors.white;
  var button2Color = const Color.fromARGB(255, 211, 211, 211);
  var button3Color = const Color.fromARGB(255, 211, 211, 211);

  late double cupSize;
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

  takeHour() {
    var hour = DateTime.now().hour;
    var minute = DateTime.now().minute;
    if (minute < 10) {
      history[2].add("$hour:0$minute");
    } else if (hour < 10) {
      history[2].add("0$hour:$minute");
    } else {
      history[2].add("$hour:$minute");
    }
  }

  increaseWater() {
    percentage = percentage + cupSize / 20;
    percentage <= 100 ? size = size - cupSize / 2000 : size = -0.2;
  }

  addCup() {
    if (isCustom) {
      history[0].add("custom");
      history[1].add(text);
      cupSize = text / 20;
    } else {
      cupSize = double.parse(cups[1][index]);
      history[0].add(cups[0][index]);
      history[1].add(cups[1][index]);
    }
    takeHour();
    increaseWater();
    notifyListeners();
  }
}
