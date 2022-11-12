import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:hive_flutter/hive_flutter.dart";
import 'package:awesome_notifications/awesome_notifications.dart';

import 'dart:io';

import 'controller/controller.dart';

import "widgets/appbar.dart";
import "widgets/mainbutton.dart";

import "screens/home.dart";
import "screens/history.dart";
import "screens/settings.dart";

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  //Notifications
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Notification',
        channelDescription: "Water notification",
        defaultColor: const Color.fromARGB(255, 0, 80, 145),
        ledColor: const Color.fromARGB(255, 59, 193, 255),
        playSound: true,
        enableLights: false,
        enableVibration: true)
  ]);

  String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  String defaultLocale = Platform.localeName;

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 0,
          channelKey: 'key1',
          title: defaultLocale == "pt_BR" || defaultLocale == "PT_PT"
              ? "Hora de tomar água"
              : "Let's drink water!",
          body: defaultLocale == "pt_BR" || defaultLocale == "PT_PT"
              ? "Um copo de água vai cair bem!"
              : "A glass of water would be great!"),
      schedule: NotificationInterval(interval: 3000, timeZone: localTimeZone, repeats: true));

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())],
      child: MaterialApp(home: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    var provider = Provider.of<Controller>(context, listen: false);

    //Hive (persistand data) management

    provider.openBox();

    Future.delayed(const Duration(seconds: 2), () {
      if (Hive.box("box0").get("list0") == null || provider.day != Hive.box("daybox").get("day")) {
        provider.createData();
        Hive.box("languagebox").get("languagemode") != null ? provider.english = false : true;
        Hive.box("darkmodebox").get("darkmode") != null ? provider.darkMode = true : false;
      } else {
        provider.loadData();
        provider.defaultPercentageSize();
      }

      provider.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 13),
            child: CustomAppBar(controller: controller)),
        body: Consumer<Controller>(builder: (context, value, child) {
          return Container(
            color: value.white,
            child: value.loading
                ? const Center(child: CircularProgressIndicator())
                : PageView(
                    controller: controller,
                    onPageChanged: (page) {
                      switch (page) {
                        case 0:
                          value.page = 0;
                          break;
                        case 1:
                          value.page = 1;
                          break;
                        case 2:
                          value.page = 2;
                          break;
                      }
                      value.changeAppBarColor();
                    },
                    children: [HomeScreen(), HistoryScreen(), SettingsScreen()]),
          );
        }),
        floatingActionButton: Consumer<Controller>(builder: (context, value, child) {
          return AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: value.page == 0 ? 1 : 0,
              child: MainButton(value: value, heroTag: "btn1"));
        }));
  }
}
