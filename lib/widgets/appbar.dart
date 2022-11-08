import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../controller/controller.dart";


class CustomAppBar extends StatelessWidget {
  var controller;

  CustomAppBar({this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (context, value, child) {
      return AppBar(actions: [
        Expanded(
            child: InkWell(
          onTap: () {
            controller.animateToPage(0, curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.water_drop, color: value.button1Color),
              Container(width: 10),
              Text("Home", style: TextStyle(color: value.button1Color))
            ],
          ),
        )),
        Expanded(
          child: InkWell(
            onTap: () {
              controller.animateToPage(1, curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, color: value.button2Color),
                Container(width: 10),
                Text("History", style: TextStyle(color: value.button2Color))
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              controller.animateToPage(2, curve: Curves.easeOut, duration: const Duration(milliseconds: 250));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, color: value.button3Color),
                Container(width: 10),
                Text("Settings", style: TextStyle(color: value.button3Color))
              ],
            ),
          ),
        ),
      ]);
    });
  }
}
