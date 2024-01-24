import 'dart:math';

import "package:flutter/material.dart";
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'dart:io';

import 'package:water_reminder/controller/ad_mob_service.dart';

class Controller extends ChangeNotifier {
  //Args for the screens
  late int index;
  late String key;
  late Controller value;

  //Loading controller
  bool loading = true;

  //Visual variables
  Color white = Colors.white;
  bool darkMode = false;
  bool english = true;
  int page = 0;
  Color grey = const Color.fromARGB(255, 102, 102, 102);
  bool usaDate = false;
  bool usaHour = false;

  Color button1Color = Colors.white;
  Color button2Color = const Color.fromARGB(255, 102, 102, 102);
  Color button3Color = const Color.fromARGB(255, 102, 102, 102);

  final String defaultLocale = Platform.localeName;

  bool sameDay = true;

  //Info variables
  String text = "";
  bool isCustom = false;
  late double cupSize;
  double percentage = 0;
  double size = 0.825;
  double goal = 2.0;
  bool ok = false;

  String day = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  late List<dynamic> list0, list1, list2, dayList, waterList;

  String dayWaterText = "";
  String currentDay = "";
  late DateTime calendarFirstDay;
  late DateTime calendarLastDay;
  int waterBottleSize = 0;
  Color goalPercentage = Colors.red;

  var cups = [
    ["cup", "glass", "big glass", "bottle", "jar", "big bottle"],
    ["100", "250", "400", "600", "800", "1000"]
  ];

  InterstitialAd? interstitialAd;

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => interstitialAd = ad,
            onAdFailedToLoad: (error) => interstitialAd = null));
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createInterstitialAd();
      });
      int adChance = Random().nextInt(5);
      if (adChance == 0) {
        interstitialAd!.show();
        interstitialAd = null;
      }
    }
  }

  Future<int> checkInterstitialAd() async {
    if (interstitialAd != null) {
      return 0;
    } else {
      return 1;
    }
  }

  BannerAd? banner;

  void createBannerAd() {
    banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.historyBannerUnitId!,
        listener: AdMobService.historyBannerAdListener,
        request: const AdRequest())
      ..load();
  }

  //Dark mode controller
  void changeDarkMode() {
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

  //Date changer
  void changeDate() {
    usaDate = !usaDate;

    if (usaDate) {
      Hive.box("usadatebox").put("usadate", usaDate);
    } else {
      Hive.box("usadatebox").clear();
    }

    notifyListeners();
  }

  //Hour changer
  void changeHour() {
    usaHour = !usaHour;

    if (usaDate) {
      Hive.box("usahourbox").put("usahour", usaHour);
    } else {
      Hive.box("usahourbox").clear();
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
    String timeIndicator = "";

    if (usaHour) {
      timeIndicator = "AM";
      if (hour >= 12) {
        hour = hour - 12;
        timeIndicator = "PM";
      } else if (hour == 0) {
        hour = 12;
      } else {
        hour = hour;
      }
    }

    if (minute < 10 && hour < 10) {
      list2.add("0$hour:0$minute $timeIndicator");
    } else if (minute < 10) {
      list2.add("$hour:0$minute $timeIndicator");
    } else if (hour < 10) {
      list2.add("0$hour:$minute $timeIndicator");
    } else {
      list2.add("$hour:$minute $timeIndicator");
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
    if(checkDay() == false){
      createData();
      defaultPercentageSize();
    }

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

  //This is the opposite, removing the cups, and does the same thing with the wave, but in reverse
  void removeCup(index) async {
    if(checkDay() == false){
      createData();
      defaultPercentageSize();
    }

    cupSize = double.parse(list1[index]) * -1.0;
    list0.removeAt(index);
    list1.removeAt(index);
    list2.removeAt(index);
    takeHour();
    increasePercentage();
    updateDatabase();

    if (percentage < 0) {
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
  Future<bool> openBox() async {
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
    await Hive.openBox("usahourbox");
    await Hive.openBox("usadatebox");

    return true;
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
    }else{
      if (defaultLocale == "pt_BR" || defaultLocale == "PT_PT") {
        english = false;
      }else{
        usaHour = true;
        usaDate = true;
      }
    }

    dayList.add(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    waterList.add(0);

    Hive.box("daybox").put("day", day);
    Hive.box("goalbox").put("goal", goal);
    Hive.box("daylistbox").put("daylist", dayList);
    Hive.box("daywaterbox").put("waterlist", waterList);
    Hive.box("usadatebox").put("usadate", usaDate);
    Hive.box("usahourbox").put("usahour", usaHour);

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
    day = Hive.box("daybox").get("day");
    dayList = Hive.box("daylistbox").get("daylist");
    waterList = Hive.box("daywaterbox").get("waterlist");

    Hive.box("darkmodebox").isNotEmpty ? darkMode = true : false;
    Hive.box("languagebox").isNotEmpty ? english = false : true;
    Hive.box("usadatebox").isNotEmpty ? usaDate = true : false;
    Hive.box("usahourbox").isNotEmpty ? usaHour = true : false;

    notifyListeners();
  }

  //This update the data, it's used when you add another cup
  void updateDatabase() async {
    Hive.box("box0").put("list0", list0);
    Hive.box("box1").put("list1", list1);
    Hive.box("box2").put("list2", list2);
    Hive.box("daybox").put("day", day);
    waterList[dayList.length - 1] = waterList[dayList.length - 1] + cupSize;
    Hive.box("daylistbox").put("daylist", dayList);
    Hive.box("daywaterbox").put("waterlist", waterList);

    createBannerAd();
    notifyListeners();
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

  void calendarIndex(dateValue) {
    int dayIndex = 0;

    if (dateValue != null) {
      dayIndex = dayList.indexOf(DateFormat('yyyy-MM-dd').format(dateValue));
    }

    DateFormat englishVisualFormatter;

    if (usaDate) {
      englishVisualFormatter = DateFormat('MM/dd/yyyy');
    } else {
      englishVisualFormatter = DateFormat('dd/MM/yyyy');
    }

    calendarFirstDay = DateTime.parse(dayList[0] + " 00:00:00.000");
    calendarLastDay =
        DateTime.parse(dayList[dayList.length - 1] + " 00:00:00.000");
    currentDay = englishVisualFormatter.format(dateValue);

    if (waterList[dayIndex] == null) {
      dayWaterText = "0.0";
      waterBottleSize = 0;
    } else {
      dayWaterText = (waterList[dayIndex] / 1000).toString();
      waterBottleSize = (double.parse(dayWaterText) / goal * 100).round();
      if (waterBottleSize > 100) {
        waterBottleSize = 100;
      }
    }

    if (waterBottleSize == 100) {
      goalPercentage = Colors.green;
    } else if (waterBottleSize > 75) {
      goalPercentage = Colors.lightGreen;
    } else if (waterBottleSize > 50) {
      goalPercentage = Colors.yellow.shade800;
    } else {
      goalPercentage = Colors.red;
    }

    notifyListeners();
  }

  bool checkDay() {
    day = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString().trim();
    if (day != Hive.box("daybox").get("day").toString().trim()) {
      sameDay = false;
    }else{
      sameDay = true;
    }
    return sameDay;
  }

  void openingApp() {
    loading = true;
    notifyListeners();
    if (checkDay() == false) {
      createData();
      english = Hive.box("languagebox").get("languagemode") == null;
      darkMode = Hive.box("darkmodebox").get("darkmode") != null;
    } else {
      loadData();
    }
    defaultPercentageSize();

    loading = false;
    notifyListeners();
  }
}
