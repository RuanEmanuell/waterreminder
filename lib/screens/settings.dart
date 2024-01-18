import 'package:alarme/controller/ad_mob_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../models/languages.dart';
import '../widgets/switch.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    createBannerAd();
  }

  BannerAd? banner;

  void createBannerAd() {
    banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var value = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
          height: screenHeight,
          width: screenWidth,
          color: value.darkMode
              ? const Color.fromARGB(255, 29, 29, 29)
              : Colors.white,
          child: Container(
            margin: EdgeInsets.all(screenHeight / 20),
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: Text(value.english ? english[6] : portuguese[6],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: value.darkMode
                              ? Colors.white
                              : const Color.fromARGB(255, 94, 94, 94))),
                ),
                DarkModeSwitch(
                    value: value,
                    provider: Provider.of<Controller>(context, listen: false))
              ]),
              SizedBox(height: screenHeight / 20),
              Row(children: [
                Expanded(
                  child: Text(value.english ? english[7] : portuguese[7],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: value.darkMode
                              ? Colors.white
                              : const Color.fromARGB(255, 94, 94, 94))),
                ),
                LanguageSwitch(
                    value: value,
                    provider: Provider.of<Controller>(context, listen: false))
              ]),
              banner == null
                  ? Container()
                  : Container(
                      height: screenHeight / 20,
                      margin: EdgeInsets.all(screenWidth / 5),
                      child: AdWidget(ad: banner!)),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: screenHeight / 7,
                      child: InkWell(
                        onTap: () async {
                          Uri url = Uri.parse(
                              'https://ruanemanuell.github.io/portfolio');
                          await launchUrl(url);
                        },
                        child: Column(
                          children: [
                            Text(
                              "Water Reminder v2.0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: value.darkMode
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            SizedBox(height: screenHeight / 100),
                            Text(value.english ? english[16] : portuguese[16],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: value.darkMode
                                        ? Colors.white
                                        : Colors.grey))
                          ],
                        ),
                      ),
                    )),
              )
            ]),
          )),
    )));
  }
}
