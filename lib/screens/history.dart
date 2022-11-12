import 'package:flutter/material.dart';
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
        body: Center(
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: value.darkMode ? const Color.fromARGB(255, 29, 29, 29) : Colors.white,
                  child: value.list0.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value.english ? english[3] : portuguese[3],
                                style: TextStyle(
                                    color: value.darkMode
                                        ? Colors.white
                                        : const Color.fromARGB(255, 94, 94, 94))),
                            const SizedBox(height: 10),
                            MainButton(value: value, heroTag: "btn2")
                          ],
                        )
                      : SizedBox(
                          height: screenHeight / 1.12,
                          child: ListView.builder(
                            itemCount: value.list0.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: CupHistoryWidget(index: index, value: value));
                            },
                          ),
                        ),
                ))));
  }
}
