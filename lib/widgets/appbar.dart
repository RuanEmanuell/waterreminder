import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../controller/controller.dart";

import "../models/languages.dart";

class CustomAppBar extends StatelessWidget {
  var controller;

  CustomAppBar({this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (context, value, child) {
      return AppBar(
          backgroundColor: value.darkMode ? const Color.fromARGB(255, 17, 17, 17) : Colors.blue,
          actions: [
            Expanded(
                child: InkWell(
              onTap: () {
                controller.animateToPage(0,
                    curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.water_drop, color: value.button1Color),
                  Container(width: 10),
                  Text(value.english ? english[0] : portuguese[0],
                      style: TextStyle(color: value.button1Color))
                ],
              ),
            )),
            InkWell(
              onTap: () {
                controller.animateToPage(1,
                    curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, color: value.button2Color),
                  Container(width: 10),
                  Text(value.english ? english[1] : portuguese[1],
                      style: TextStyle(color: value.button2Color))
                ],
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.animateToPage(2,
                      curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: value.button3Color),
                    Container(width: 10),
                    Text(value.english ? english[2] : portuguese[2],
                        style: TextStyle(color: value.button3Color))
                  ],
                ),
              ),
            ),
          ]);
    });
  }
}
