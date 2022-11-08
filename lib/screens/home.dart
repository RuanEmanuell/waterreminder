import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import "package:wave/wave.dart";

import "../controller/controller.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(actions: [
          Expanded(
              child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.water_drop), Container(width: 10), const Text("Home")],
            ),
          )),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, color: Color.fromARGB(255, 199, 199, 199)),
                  Container(width: 10),
                  const Text("History", style: TextStyle(color: Color.fromARGB(255, 199, 199, 199)))
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.settings, color: Color.fromARGB(255, 199, 199, 199)),
                  Container(width: 10),
                  const Text("Settings", style: TextStyle(color: Color.fromARGB(255, 199, 199, 199)))
                ],
              ),
            ),
          ),
        ]),
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
                      margin: EdgeInsets.only(top: screenHeight / 2.5),
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
          ),
        ),
        floatingActionButton: Consumer<Controller>(builder: (context, value, child) {
          return FloatingActionButton(
              onPressed: () {
                if(value.percentage<100){
                value.increaseWater();
              }
              },
              backgroundColor: value.size >= 0.7 ? Colors.blue : Colors.white,
              child: Icon(Icons.add, size: 30, color: value.size >= 0.7 ? Colors.white : Colors.blue));
        }));
  }
}
