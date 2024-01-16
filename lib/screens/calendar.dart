import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import "../controller/controller.dart";

import "../models/languages.dart";

import '../widgets/cupadd.dart';
import "../widgets/dialog.dart";

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var value = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: value.darkMode
                ? const Color.fromARGB(255, 17, 17, 17)
                : Colors.blue,
            centerTitle: true,
            title: Text(value.english ? english[10] : portuguese[10])),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Consumer<Controller>(builder: ((context, value, child) {
              return Container(
                  color: value.darkMode ? Colors.blue : Colors.white,
                  width: screenWidth,
                  child: Column(children: [
                    Container(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: value.darkMode
                                ? ColorScheme.dark(
                                    onPrimary: Colors.black,
                                    onSurface: Colors.white,
                                    primary: Colors.white,
                                  )
                                : ColorScheme.dark(
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                    primary: Colors.blue,
                                  )),
                        child: Builder(builder: (context) {
                          return CalendarDatePicker(
                              initialDate: value.calendarLastDay,
                              firstDate: value.calendarFirstDay,
                              lastDate: value.calendarLastDay,
                              onDateChanged: (dateValue) {
                                value.calendarIndex(dateValue);
                              });
                        }),
                      ),
                    ),
                    Container(
                        width: screenWidth,
                        height: screenHeight / 2.5,
                        decoration: BoxDecoration(
                            color: value.darkMode
                                ? const Color.fromARGB(255, 17, 17, 17)
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight / 40),
                            Text(value.currentDay,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth / 15)),
                            SizedBox(height: screenHeight / 40),
                            Container(
                                width: screenWidth / 1.25,
                                height: screenHeight / 4,
                                decoration: BoxDecoration(
                                    color: value.darkMode
                                        ? const Color.fromARGB(255, 17, 17, 17)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${value.english ? english[13] : portuguese[13]} ${value.dayWaterText}L",
                                        style: TextStyle(
                                            color: value.darkMode
                                                ? Colors.white
                                                : Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth / 20)),
                                    Text(
                                        "${value.english ? english[14] : portuguese[14]} ${value.goal}L",
                                        style: TextStyle(
                                            color: value.darkMode
                                                ? Colors.white
                                                : Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth / 20)),
                                    SizedBox(height: screenHeight / 40),
                                    Container(
                                        height: screenHeight / 20,
                                        width: screenWidth / 1.8,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: value.darkMode
                                                    ? Colors.white
                                                    : Colors.grey,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            AnimatedContainer(
                                              width: value.waterBottleSize *
                                                  screenWidth /
                                                  183.25,
                                              curve: Curves.easeInOut,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              height: screenHeight / 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            )
                                          ],
                                        )),
                                    SizedBox(height: screenHeight / 80),
                                    Text(
                                        "${value.waterBottleSize}${value.english ? english[15] : portuguese[15]}",
                                        style: TextStyle(
                                            color: value.goalPercentage,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth / 20))
                                  ],
                                ))
                          ],
                        ))
                  ]));
            }))));
  }
}
