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
    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Consumer<Controller>(
            builder: (context, value, child) {
              return Column(
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
                        child: Text("${value.percentage}%",
                            style: TextStyle(
                                fontSize: 40, color: value.size >= 0.4 ? Colors.blue : Colors.white)),
                      ),
                    )
                  ])
                ],
              );
            },
          )),
    );
  }
}
