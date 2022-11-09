import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

import "../widgets/cuphistory.dart";
import "../widgets/mainbutton.dart";

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Consumer<Controller>(
              builder: (context, value, child) {
                return value.history[0].isEmpty
                    ? Column(
                        children: [
                          const Text("It looks like you still don't have drink water today...",
                              style: TextStyle(color: Color.fromARGB(255, 80, 80, 80))),
                          const SizedBox(height: 10),
                          MainButton(value: value, heroTag: "btn2")
                        ],
                      )
                    : SizedBox(
                        height: screenHeight / 1.15,
                        child: ListView.builder(
                          itemCount: value.history[0].length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                child: CupHistoryWidget(index: index, value: value));
                          },
                        ),
                      );
              },
            )),
      ),
    );
  }
}
