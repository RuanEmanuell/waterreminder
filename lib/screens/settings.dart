import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../models/languages.dart';
import '../widgets/switch.dart';

class SettingsScreen extends StatelessWidget {
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
          child: Container(
            margin: EdgeInsets.all(screenHeight / 20),
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: Text(value.english ? english[6] : portuguese[6],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: value.darkMode ? Colors.white : Colors.grey)),
                ),
                DarkModeSwitch(value: value, provider: Provider.of<Controller>(context, listen: false))
              ]),
              SizedBox(height: screenHeight / 20),
              Row(children: [
                Expanded(
                  child: Text(value.english ? english[7] : portuguese[7],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: value.darkMode ? Colors.white : Colors.grey)),
                ),
                LanguageSwitch(value: value, provider: Provider.of<Controller>(context, listen: false))
              ]),
            ]),
          )),
    )));
  }
}
