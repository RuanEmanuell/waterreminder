import 'package:alarme/screens/add.dart';
import 'package:alarme/screens/calendar.dart';
import 'package:alarme/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

import '../models/languages.dart';
import "../widgets/cuphistory.dart";
import "../widgets/mainbutton.dart";

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var value = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  color: value.darkMode
                      ? const Color.fromARGB(255, 29, 29, 29)
                      : Colors.white,
                  child: value.list0.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value.english ? english[3] : portuguese[3],
                                style: TextStyle(
                                    color: value.darkMode
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 94, 94, 94))),
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
                            )
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
                                        removeButtonVisible: true));
                              }),
                        ),
                ))),
                floatingActionButton: MainButton(
                  heroTag: "btn4",
                  value: value,
                  icon: Icons.calendar_month,
                  onPressed: (){
                    value.calendarIndex(DateTime.parse(value.dayList[value.dayList.length-1]));
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
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,);
  }
}
