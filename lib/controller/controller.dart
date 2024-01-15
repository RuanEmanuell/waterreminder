import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart'; 
import 'package:intl/date_symbol_data_local.dart'; 

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
  double goal = 2.0;
  bool ok = false;

  String day = "${DateTime.now().day}";

  late List<dynamic> list0, list1, list2, dayList, waterList;

  String dayWaterText = "";
  String currentDay = "";
  late DateTime calendarFirstDay;
  late DateTime calendarLastDay;
  double waterBottleSize = 0.0;

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
  void changeLanguage() {
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
    button1Color = grey;
    button2Color = grey;
    button3Color = grey;

    switch (page) {
      case 0:
        button1Color = white;
        break;
      case 1:
        button2Color = white;
        break;
      case 2:
        button3Color = white;
        break;
    }

    notifyListeners();
  }

  //////////////Below there are the add cup functions///////////////////////////

  //This one takes the time where you added the cup
  void takeHour() {
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
  void increasePercentage() {
    percentage = percentage + cupSize / (goal * 10);
    percentage <= 100 ? size = size - cupSize / (goal * 1000) : size = -0.2;
  }

  //This one is the main function for adding cups, being custom it send the
  //custom cup and the text you tiped alongside with the cupSize for the wave,
  //if it's not custom it will only send the cup data and the cupSize
  void addCup() async {
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

    print(waterList);
    print(dayList);
  }

  //This is the opposite, removing the cups, and does the same thing with the wave, but in reverse
  void removeCup(index) async {
    cupSize = double.parse(list1[index]) * -1.0;
    list0.removeAt(index);
    list1.removeAt(index);
    list2.removeAt(index);
    takeHour();
    increasePercentage();
    updateDatabase();

    if(percentage < 0){
      percentage = 0;
    }

    notifyListeners();
  }

  ///////////////Below there are Hive and persistant data functions/////////////

  //Deciding what percentage will be displayed when you open the app based
  //on the items that are on the history
  void defaultPercentageSize() {
    percentage = 0;
    size = 0.825;

    for (var i in list1) {
      i = double.parse(i);
      percentage = percentage + i / (goal * 10);
    }

    if (percentage >= 0 && percentage <= 100) {
      size = 0.825 - (percentage / 100);
    } else {
      size = -0.2;
    }
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
    await Hive.openBox("goalbox");
    await Hive.openBox("daylistbox");
    await Hive.openBox("daywaterbox");
  }

  //This create data if it's your first time opening the app
  void createData() async {
    list0 = [];
    list1 = [];
    list2 = [];
    dayList = [];
    waterList = [];

    if (Hive.box("daylistbox").get("daylist") != null) {
      dayList = Hive.box("daylistbox").get("daylist");
      waterList = Hive.box("daywaterbox").get("waterlist");
    } 

    if (defaultLocale == "pt_BR" || defaultLocale == "PT_PT") {
      english = false;
    }

    dayList.add(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    waterList.add(0);

    Hive.box("daybox").put("day", day);
    Hive.box("goalbox").put("goal", goal);
    Hive.box("daylistbox").put("daylist", dayList);
    Hive.box("daywaterbox").put("waterlist", waterList);
    notifyListeners();
  }

  //This load data if already has data
  void loadData() async {
    list0 = Hive.box("box0").get("list0");
    list1 = Hive.box("box1").get("list1");
    list2 = Hive.box("box2").get("list2");
    goal = Hive.box("goalbox").get("goal");
    Hive.box("darkmodebox").get("darkmode");
    Hive.box("languagebox").get("languagemode");
    dayList = Hive.box("daylistbox").get("daylist");
    waterList = Hive.box("daywaterbox").get("waterlist");

    Hive.box("darkmodebox").isNotEmpty ? darkMode = true : false;
    Hive.box("languagebox").isNotEmpty ? english = false : true;

    notifyListeners();
  }

  //This update the data, it's used when you add another cup
  void updateDatabase() async {
    Hive.box("box0").put("list0", list0);
    Hive.box("box1").put("list1", list1);
    Hive.box("box2").put("list2", list2);
    waterList[dayList.length - 1] = waterList[dayList.length - 1] + cupSize;
    Hive.box("daylistbox").put("daylist", dayList);
    Hive.box("daywaterbox").put("waterlist", waterList);
  }

  void changeGoal(goalValue) async {
    Hive.box("goalbox").put("goal", goalValue);
    notifyListeners();
  }

  void dismissGoal(changedGoal) {
    if (changedGoal) {
      changeGoal(goal);
      defaultPercentageSize();
    } else {
      goal = Hive.box("goalbox").get("goal");
    }
    notifyListeners();
  }

  //This one sets ok for the message dialog, making it never appear again
  void okFunction() {
    ok = true;
    Hive.box("mensagebox").put("ok", ok);
  }

  void calendarIndex(dateValue){
    int dayIndex = 0;

    if(dateValue != null){
      dayIndex = dayList.indexOf(DateFormat('yyyy-MM-dd').format(dateValue));
    }

    calendarFirstDay =  DateTime.parse(dayList[0] + " 00:00:00.000");
    calendarLastDay  =  DateTime.parse(dayList[dayList.length-1] + " 00:00:00.000");
    dayWaterText = (waterList[dayIndex]/1000).toString();
    currentDay = DateFormat('dd/MM/yyyy').format(dateValue);
    waterBottleSize = (double.parse(dayWaterText) / goal * 100);
    notifyListeners();
  }


}
