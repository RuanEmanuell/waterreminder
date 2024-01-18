import 'dart:math';

import 'package:water_reminder/controller/ad_mob_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import "../controller/controller.dart";

import "../models/languages.dart";

import '../widgets/cupadd.dart';
import "../widgets/dialog.dart";

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    super.initState();
    createInterstitialAd();
  }

  InterstitialAd? interstitialAd;

  int adChance = Random().nextInt(2);

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
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var value = Provider.of<Controller>(context, listen: false);

    var textController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: value.darkMode
                ? const Color.fromARGB(255, 17, 17, 17)
                : Colors.blue,
            centerTitle: true,
            title: Text(value.english ? english[4] : portuguese[4])),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            color: value.darkMode ? Colors.black : Colors.white,
            width: screenWidth,
            child: Column(children: [
              SizedBox(height: screenHeight / 20),
              SizedBox(
                height: screenHeight / 2,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: value.cups[0].length,
                  itemBuilder: (context, index) {
                    return CupAddWidget(
                        cup: value.cups[0][index],
                        size: value.cups[1][index],
                        value: value,
                        onTap: () {
                          value.index = index;
                          value.isCustom = false;
                          value.addCup();
                          Navigator.pop(context);
                          if (adChance == 0) {
                            showInterstitialAd();
                          }
                        });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                          textController: textController, value: value);
                    },
                  ).then((value) {
                    if (adChance == 0) {
                      showInterstitialAd();
                    }
                  });
                },
                child: SizedBox(
                  height: screenHeight / 2,
                  child: Column(
                    children: [
                      Image.asset("assets/images/custom.png", scale: 2),
                      Container(height: 10),
                      Text(value.english ? english[5] : portuguese[5],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 20,
                            color: value.darkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 94, 94, 94),
                          ))
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
