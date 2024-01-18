import 'package:water_reminder/controller/ad_mob_service.dart';
import 'package:water_reminder/screens/add.dart';
import 'package:water_reminder/screens/calendar.dart';
import 'package:water_reminder/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

import '../models/languages.dart';
import "../widgets/cuphistory.dart";
import "../widgets/mainbutton.dart";

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    createBannerAd();
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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var value = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      backgroundColor:
          value.darkMode ? const Color.fromARGB(255, 29, 29, 29) : Colors.white,
      body: Center(
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                child: value.list0.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(value.english ? english[3] : portuguese[3],
                              style: TextStyle(
                                  color: value.darkMode
                                      ? Colors.white
                                      : const Color.fromARGB(255, 94, 94, 94))),
                          const SizedBox(height: 10),
                          MainButton(
                            value: value,
                            heroTag: "btn3",
                            icon: Icons.add,
                            onPressed: () {
                              if (value.percentage >= 100 &&
                                  Hive.box("mensagebox").get("ok") == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WarningDialog(value: value);
                                  },
                                );
                              }
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AddScreen();
                                },
                              ));
                            },
                          ),
                          banner == null
                              ? Container()
                              : Container(
                                  width: screenWidth,
                                  height: AdSize.fullBanner.height.toDouble(),
                                  margin: EdgeInsets.all(screenWidth / 5),
                                  child: AdWidget(ad: banner!)),
                        ],
                      )
                    : SizedBox(
                        height: screenHeight / 1.12,
                        child: ListView.builder(
                            itemCount: value.list0.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 1))),
                                  alignment: Alignment.center,
                                  child: CupHistoryWidget(
                                      index: index,
                                      value: value,
                                      removeButtonVisible: true,
                                      removeDialog: true));
                            }),
                      ),
              ))),
      floatingActionButton: MainButton(
        heroTag: "btn4",
        value: value,
        icon: Icons.calendar_month,
        onPressed: () {
          value.calendarIndex(
              DateTime.parse(value.dayList[value.dayList.length - 1]));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CalendarScreen();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
