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
                    CalendarDatePicker(
                        initialDate: value.calendarLastDay,
                        firstDate: value.calendarFirstDay,
                        lastDate: value.calendarLastDay,
                        onDateChanged: (dateValue) {
                          value.calendarIndex(dateValue);
                        }),
                    Text(value.dayWaterText)
                  ]));
            }))));
  }
}
