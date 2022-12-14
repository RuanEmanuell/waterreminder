import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';

import 'dart:io';

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
  bool english = true;
  var page = 0;
  var grey = const Color.fromARGB(255, 102, 102, 102);

  var button1Color = Colors.white;
  var button2Color = const Color.fromARGB(255, 102, 102, 102);
  var button3Color = const Color.fromARGB(255, 102, 102, 102);

  final String defaultLocale = Platform.localeName;

  //Info variables
  String text = "";
  bool isCustom = false;
  late double cupSize;
  double percentage = 0;
  double size = 0.825;
  bool ok = false;

  String day = "${DateTime.now().day}";

  dynamic list0;
  dynamic list1;
  dynamic list2;

  var cups = [
    ["cup", "glass", "big glass", "bottle", "jar", "big bottle"],
    ["100", "250", "400", "600", "800", "1000"]
  ];

  //Dark mode controller
  changeDarkMode() {
    darkMode = !darkMode;
    if (darkMode) {
      Hive.box("darkmodebox").put("darkmode", darkMode);
    } else {
      Hive.box("darkmodebox").clear();
    }
    notifyListeners();
  }

  //Language changer
  changeLanguage() {
    english = !english;
    if (!english) {
      Hive.box("languagebox").put("languagemode", english);
    } else {
      Hive.box("languagebox").clear();
    }
    notifyListeners();
  }

  //AppBar color function
  changeAppBarColor() {
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
    percentage <= 100 ? size = size - cupSize / 1900 : size = -0.2;
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

    percentage <= 100 ? size = size - (percentage / 95) : size = -0.2;
  }

  //These are the Hive functions, this one opens the data box
  void openBox() async {
    await Hive.openBox("box0");
    await Hive.openBox("box1");
    await Hive.openBox("box2");
    await Hive.openBox("darkmodebox");
    await Hive.openBox("languagebox");
    await Hive.openBox("daybox");
    await Hive.openBox("mensagebox");
  }

  //This create data if it's your first time opening the app
  void createData() async {
    list0 = [];
    list1 = [];
    list2 = [];
    if (defaultLocale == "pt_BR" || defaultLocale == "PT_PT") {
      english = false;
    }
    Hive.box("daybox").put("day", day);
    notifyListeners();
  }

  //This load data if already has data
  void loadData() async {
    list0 = Hive.box("box0").get("list0");
    list1 = Hive.box("box1").get("list1");
    list2 = Hive.box("box2").get("list2");
    Hive.box("darkmodebox").get("darkmode");
    Hive.box("languagebox").get("languagemode");

    Hive.box("darkmodebox").isNotEmpty ? darkMode = true : false;
    Hive.box("languagebox").isNotEmpty ? english = false : true;

    notifyListeners();
  }

  //This update the data, it's used when you add another cup
  void updateDatabase() async {
    Hive.box("box0").put("list0", list0);
    Hive.box("box1").put("list1", list1);
    Hive.box("box2").put("list2", list2);
  }

  //This one sets ok for the message dialog, making it never appear again
  void okFunction() {
    ok = true;
    Hive.box("mensagebox").put("ok", ok);
  }
}
