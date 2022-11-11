import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import "package:wave/wave.dart";

import '../controller/controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var value = Provider.of<Controller>(context, listen: false);
    bool isOn = false;
    return Scaffold(
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              color: value.darkMode ? const Color.fromARGB(255, 29, 29, 29) : Colors.white,
              child: Column(
                children: [
                  Stack(children: [
                    WaveWidget(
                      size: Size(screenWidth, screenHeight),
                      config: CustomConfig(gradients: [
                        [const Color.fromARGB(255, 10, 110, 192), Colors.lightBlue],
                        [Colors.blue, Colors.lightBlue],
                      ], heightPercentages: [
                        value.size,
                        value.size
                      ], durations: [
                        5000,
                        6000
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight / 2.65),
                      child: Center(
                        child: Text("${value.percentage.toStringAsFixed(0)}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth / 10,
                                color: value.size >= 0.34
                                    ? Colors.blue
                                    : value.darkMode
                                        ? const Color.fromARGB(255, 29, 29, 29)
                                        : Colors.white)),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: FlutterSwitch(
                          inactiveColor: Colors.grey,
                          activeColor: const Color.fromARGB(255, 0, 84, 153),
                          inactiveIcon: const Icon(Icons.sunny, color: Color.fromARGB(255, 226, 204, 0)),
                          activeIcon: const Icon(Icons.nightlight, color: Colors.grey),
                          value: value.darkMode,
                          onToggle: (value) {
                            Provider.of<Controller>(context, listen: false).changeDarkMode();
                          },
                        ),
                      ),
                    )
                  ])
                ],
              ),
            )));
  }
}
