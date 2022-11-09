import 'package:flutter/material.dart';

import "../widgets/cups.dart";
import "../widgets/dialog.dart";

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
                        onTap: () {
                          value.index = index;
                          value.isCustom = false;
                          value.addCup();
                          Navigator.pop(context);
                        });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(textController: textController, value: value);
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
