import 'dart:async';

import 'package:water_reminder/models/languages.dart';
import 'package:water_reminder/screens/add.dart';
import 'package:water_reminder/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'dart:io';

import 'controller/controller.dart';

import 'widgets/appbar.dart';
import 'widgets/mainbutton.dart';

import 'screens/home.dart';
import 'screens/history.dart';
import 'screens/settings.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  // Notifications
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'Notification',
      channelDescription: "Water notification",
      defaultColor: const Color.fromARGB(255, 0, 80, 145),
      ledColor: const Color.fromARGB(255, 59, 193, 255),
      playSound: true,
      enableLights: false,
      enableVibration: true
    ),
  ]);

  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
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
          : "A glass of water would be great!",
    ),
    schedule: NotificationInterval(
      interval: 3000,
      timeZone: localTimeZone,
      repeats: true,
    ),
  );

  unawaited(MobileAds.instance.initialize());

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => Controller())],
    child: MaterialApp(home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  var controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    var provider = Provider.of<Controller>(context, listen: false);

    provider.openBox().then((value) {
      provider.openingApp();
    });
      SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var provider = Provider.of<Controller>(context, listen: false);
    state = state;
    if (state == AppLifecycleState.resumed) {
      provider.openBox();
      provider.openingApp();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight / 13),
        child: CustomAppBar(controller: controller),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Container(
            color: value.white,
            child: value.loading
                ? const Center(child: CircularProgressIndicator())
                : PageView(
                    controller: controller,
                    onPageChanged: (page) {
                      value.page = page;
                      value.changeAppBarColor();
                    },
                    children: [
                      HomeScreen(),
                      HistoryScreen(),
                      SettingsScreen(),
                    ],
                  ),
          );
        },
      ),
      floatingActionButton: Consumer<Controller>(
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: screenWidth / 13),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: value.page == 0 ? 1 : 0,
                  child: MainButton(
                    value: value,
                    heroTag: "btn2",
                    icon: Icons.local_drink,
                    onPressed: () {
                      if (value.page == 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content:
                                StatefulBuilder(builder: (context, setState) {
                              return Container(
                                height: screenHeight / 4,
                                width: screenWidth / 2,
                                color: value.darkMode ? Colors.blue : Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(height: screenHeight/35),
                                    Text(
                                      value.english
                                          ? english[11]
                                          : portuguese[11], style: TextStyle(
                                      color: value.darkMode ? Colors.white : Colors.black,
                                          )
                                    ),
                                    Text("${value.goal}L", style: TextStyle(
                                      color: value.darkMode ? Colors.white : Colors.black,
                                    )),
                                    Slider(
                                      inactiveColor: value.darkMode ? Colors.white : Colors.blue,
                                      activeColor: value.darkMode ? Colors.white : Colors.blue,
                                      min: 1,
                                      max: 10,
                                      divisions: 18,
                                      value: value.goal,
                                      onChanged: (sliderValue) {
                                        setState((() {
                                          value.goal = sliderValue;
                                        }));
                                      },
                                    ),
                                    InkWell(
                                        child: Container(
                                          height: screenHeight / 15,
                                          width: screenWidth / 2,
                                          decoration: BoxDecoration(
                                            color: value.darkMode ? const Color.fromARGB(255, 17, 17, 17) : Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              value.english
                                                  ? english[12]
                                                  : portuguese[12],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          value.dismissGoal(true);
                                        }),
                                  ],
                                ),
                              );
                            }));
                          },
                        ).then(((dialogValue) {
                          value.dismissGoal(false);
                        }));
                      }
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: value.page == 0 ? 1 : 0,
                child: MainButton(
                    value: value,
                    heroTag: "btn1",
                    icon: Icons.add,
                    onPressed: () {
                      if (value.page == 0) {
                        if (value.percentage >= 100 &&
                            Hive.box("mensagebox").get("ok") == null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return WarningDialog(value: value);
                            },
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddScreen();
                            },
                          ),
                        );
                      }
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
