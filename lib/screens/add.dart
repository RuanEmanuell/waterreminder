import 'package:flutter/material.dart';

import "../widgets/cups.dart";

class AddScreen extends StatelessWidget {
  var value;

  AddScreen({required this.value});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var textController = TextEditingController();
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Select a cup")),
        body: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            child: Column(children: [
              SizedBox(height: screenHeight / 20),
              SizedBox(
                height: screenHeight / 2.15,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: value.cups[0].length,
                  itemBuilder: (context, index) {
                    return CupWidget(
                        cup: value.cups[0][index],
                        size: value.cups[1][index],
                        index: index,
                        value: value);
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(content: const Text("Add other size (ml)"), actions: [
                        TextField(
                            maxLength: 4,
                            controller: textController,
                            keyboardType: TextInputType.number),
                        TextButton(
                            onPressed: () {
                              var hour = DateTime.now().hour;
                              var minute = DateTime.now().minute;

                              value.history[0].add(textController.text);
                              value.history[1].add("custom");

                              if (minute < 10) {
                                value.history[2].add("$hour:0$minute");
                              } else if (hour < 10) {
                                value.history[2].add("0$hour:$minute");
                              } else {
                                value.history[2].add("$hour:$minute");
                              }

                              value.cupSize = int.parse(textController.text);

                              value.addCup();

                              value.increaseWater();

                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"))
                      ]);
                    },
                  );
                },
                child: Column(
                  children: [
                    Image.asset("assets/images/custom.png", scale: 2),
                    Container(height: 10),
                    const Text("Custom")
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
