// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:water_reminder/controller/controller.dart';
import "package:flutter/material.dart";
import 'package:flutter_switch/flutter_switch.dart';

class DarkModeSwitch extends StatelessWidget {
  final Controller value;
  final Controller provider;

  const DarkModeSwitch({super.key, required this.value, required this.provider});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        inactiveColor: const Color.fromARGB(255, 94, 94, 94),
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
  final Controller value;
  final Controller provider;

  const LanguageSwitch({required this.value, required this.provider});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        inactiveColor: Colors.green,
        activeColor: Colors.blue.shade800,
        inactiveToggleColor: Colors.yellow,
        activeToggleColor: Colors.red,
        inactiveIcon: Image.asset("assets/images/brasil.png"),
        activeIcon: Image.asset("assets/images/usa.png"),
        value: value.english,
        onToggle: (value) {
          provider.changeLanguage();
        });
  }
}

class DateSwitch extends StatelessWidget {
  final Controller value;
  final Controller provider;

  const DateSwitch({required this.value, required this.provider});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        inactiveColor: const Color.fromARGB(255, 94, 94, 94),
        activeColor: Colors.lightGreen,
        activeIcon: Icon(Icons.date_range),
        inactiveIcon: Icon(Icons.date_range),
        value: value.usaDate,
        onToggle: (value) {
          provider.changeDate();
        });
  }
}

class HourSwitch extends StatelessWidget {
  final Controller value;
  final Controller provider;

  const HourSwitch({required this.value, required this.provider});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        inactiveColor: const Color.fromARGB(255, 94, 94, 94),
        activeColor: Colors.blue,
        activeIcon: Icon(Icons.punch_clock),
        inactiveIcon: Icon(Icons.punch_clock),
        value: value.usaHour,
        onToggle: (value) {
          provider.changeHour();
        });
  }
}
