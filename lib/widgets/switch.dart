import "package:flutter/material.dart";
import 'package:flutter_switch/flutter_switch.dart';

class DarkModeSwitch extends StatelessWidget {
  var value;
  var provider;

  DarkModeSwitch({required this.value, required this.provider});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        inactiveColor: Colors.grey,
        activeColor: const Color.fromARGB(255, 0, 84, 153),
        inactiveIcon: const Icon(Icons.sunny, color: Color.fromARGB(255, 226, 204, 0)),
        activeIcon: const Icon(Icons.nightlight, color: Colors.grey),
        value: value.darkMode,
        onToggle: (value) {
          provider.changeDarkMode();
        });
  }
}


class LanguageSwitch extends StatelessWidget {
  var value=false;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        inactiveColor: Colors.green,
        activeColor: Colors.blue.shade700,
        inactiveToggleColor: Colors.yellow,
        activeToggleColor: Colors.red,
        inactiveIcon: Image.asset("assets/images/brasil.png"),
        activeIcon: Image.asset("assets/images/usa.png"),
        value: value,
        onToggle: (value) {
          value=!value;
        });
  }
}

