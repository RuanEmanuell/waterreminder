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
            backgroundColor: value.darkMode ? Colors.black : Colors.blue,
            centerTitle: true,
            title: Text(value.english ? english[10] : portuguese[10])),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Consumer<Controller>(builder: ((context, value, child) {
              return Container(
                  color: value.darkMode ? Colors.black : Colors.white,
                  width: screenWidth,
                  child: Column(children: [
                    Container(
                      child: CalendarDatePicker(
                          initialDate: value.calendarLastDay,
                          firstDate: value.calendarFirstDay,
                          lastDate: value.calendarLastDay,
                          onDateChanged: (dateValue) {
                            value.calendarIndex(dateValue);
                          }),
                    ),
                    Container(
                        width: screenWidth,
                        height: screenHeight / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Total de água no dia: ${value.dayWaterText}L",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth / 20)),
                                    Text("Meta atual de água: ${value.goal}L",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth / 20)),
                                    SizedBox(height: screenHeight / 40),
                                    Container(
                                        height: screenHeight / 20,
                                        width: screenWidth / 1.8,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: value.waterBottleSize.round(),
                                              child: Container(
                                                height: screenHeight / 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                              ),
                                            ),
                                            Expanded(flex: 100 - value.waterBottleSize.round(),child: Container())
                                          ],
                                        ))
                                  ],
                                ))
                          ],
                        ))
                  ]));
            }))));
  }
}
