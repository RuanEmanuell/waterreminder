import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../controller/controller.dart";

import '../widgets/cupadd.dart';
import "../widgets/dialog.dart";

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var value = Provider.of<Controller>(context, listen: false);

    var textController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: value.darkMode ? Colors.black : Colors.blue,
            centerTitle: true,
            title: const Text("Select a cup")),
        body: SingleChildScrollView(
          child: Container(
            color: value.darkMode ? Colors.black : Colors.white,
            width: screenWidth,
            child: Column(children: [
              SizedBox(height: screenHeight / 20),
              SizedBox(
                height: screenHeight / 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: value.cups[0].length,
                  itemBuilder: (context, index) {
                    return CupAddWidget(
                        cup: value.cups[0][index],
                        size: value.cups[1][index],
                        value: value,
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
                child: SizedBox(
                  height: screenHeight / 2,
                  child: Column(
                    children: [
                      Image.asset("assets/images/custom.png", scale: 2),
                      Container(height: 10),
                      Text("Custom",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 20,
                            color: value.darkMode ? Colors.white : Colors.black,
                          ))
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
