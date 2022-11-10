import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';

class Controller extends ChangeNotifier {
  //Args for the screens
  var index;
  var key;
  var value;

  //Loading controller
  bool loading = true;

  //Visual variables
  var white = Colors.white;
  bool darkMode = false;
  var page = 0;
  var grey = const Color.fromARGB(255, 116, 116, 116);
  var darkGrey = const Color.fromARGB(255, 116, 116, 116);

  var button1Color = Colors.white;
  var button2Color = const Color.fromARGB(255, 211, 211, 211);
  var button3Color = const Color.fromARGB(255, 211, 211, 211);

  //Info variables
  String text = "";
  bool isCustom = false;
  late double cupSize;
  double percentage = 0;
  double size = 0.82;
  bool ok = false;

  dynamic list0;
  dynamic list1;
  dynamic list2;

  var cups = [
    ["cup", "glass", "big glass", "bottle", "jar", "big bottle"],
    ["100", "250", "400", "600", "800", "1000"]
  ];

  changeDarkMode() {
    darkMode = !darkMode;
    notifyListeners();
  }

  //AppBar color function
  changeAppBarColor() {
    switch (page) {
      case 0:
        button1Color = white;
        button2Color = darkMode ? darkGrey : grey;
        button3Color = darkMode ? darkGrey : grey;
        break;
      case 1:
        button1Color = darkMode ? darkGrey : grey;
        button2Color = white;
        button3Color = darkMode ? darkGrey : grey;
        break;
      case 2:
        button1Color = darkMode ? darkGrey : grey;
        button2Color = darkMode ? darkGrey : grey;
        button3Color = white;
        break;
    }
    notifyListeners();
  }

  //////////////Below there are the add cup functions///////////////////////////

  //This one takes the time where you added the cup
  takeHour() {
    var hour = DateTime.now().hour;
    var minute = DateTime.now().minute;
    if (minute < 10) {
      list2.add("$hour:0$minute");
    } else if (hour < 10) {
      list2.add("0$hour:$minute");
    } else {
      list2.add("$hour:$minute");
    }
  }

  //This increase the percentage and the wave size, respectively
  increasePercentage() {
    percentage = percentage + cupSize / 20;
    percentage <= 100 ? size = size - cupSize / 2000 : size = -0.2;
  }

  //This one is the main function for adding cups, being custom it send the
  //custom cup and the text you tiped alongside with the cupSize for the wave,
  //if it's not custom it will only send the cup data and the cupSize
  addCup() async {
    if (isCustom) {
      list0.add("custom");
      list1.add(text);
      cupSize = double.parse(text);
    } else {
      cupSize = double.parse(cups[1][index]);
      list0.add(cups[0][index]);
      list1.add(cups[1][index]);
    }
    takeHour();
    increasePercentage();
    updateDatabase();
    notifyListeners();
  }

  ///////////////Below there are Hive and persistant data functions/////////////

  //Deciding what percentage will be displayed when you open the app based
  //on the items that are on the history
  void defaultPercentageSize() {
    for (var i in list1) {
      i = int.parse(i);
      percentage = percentage + i / 20;
    }

    percentage <= 100 ? size = size - (percentage / 110) : size = -0.2;
  }

  //These are the Hive functions, this one opens the data box
  void openBox() async {
    await Hive.openBox("box0");
    await Hive.openBox("box1");
    await Hive.openBox("box2");
  }

  //This create data if it's your first time opening the app
  void createData() async {
    list0 = [];
    list1 = [];
    list2 = [];
    notifyListeners();
  }

  //This load data if already has data
  void loadData() async {
    list0 = Hive.box("box0").get("list0");
    list1 = Hive.box("box1").get("list1");
    list2 = Hive.box("box2").get("list2");
    notifyListeners();
  }

  //This update the data, it's used when you add another cup
  void updateDatabase() async {
    Hive.box("box0").put("list0", list0);
    Hive.box("box1").put("list1", list1);
    Hive.box("box2").put("list2", list2);
  }
}
