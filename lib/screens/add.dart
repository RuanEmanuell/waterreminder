import 'package:flutter/material.dart';


import "../widgets/cups.dart";

class AddScreen extends StatelessWidget {
  var value;

  AddScreen({required this.value});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Select a cup")),
        body: SizedBox(
          width: screenWidth,
          child: Column(children: [
            SizedBox(height: screenHeight / 20),
            SizedBox(
              height: screenHeight / 2.15,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: value.cups.length,
                itemBuilder: (context, index) {
                  return CupWidget(
                      cup: value.cups[index], size: value.sizes[index], index: index, value: value);
                },
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Image.asset("assets/images/custom.png", scale: 2),
                  Container(height: 10),
                  const Text("Custom")
                ],
              ),
            )
          ]),
        ));
  }
}
