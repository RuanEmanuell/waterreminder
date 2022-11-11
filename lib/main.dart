import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:hive_flutter/hive_flutter.dart";
import 'package:awesome_notifications/awesome_notifications.dart';
import "package:cron/cron.dart";

import 'controller/controller.dart';

import "widgets/appbar.dart";
import "widgets/mainbutton.dart";

import "screens/home.dart";
import "screens/history.dart";
import "screens/settings.dart";

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: Color.fromARGB(255, 110, 45, 190),
            ledColor: Colors.white,
            playSound: false,
            enableLights: false,
            enableVibration: true)
      ]);

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

    final cron = Cron();

    cron.schedule(Schedule.parse('*/1 * * * *'), () async {
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: "key1",
              title: provider.english ? "Time to drink water!" : "Hora de beber água!",
              body: provider.english ? "A cup would be great!" : "Um copo vai cair bem!"));
    });

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
