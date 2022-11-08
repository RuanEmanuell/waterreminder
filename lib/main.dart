import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "controller/controller.dart";

import "screens/home.dart";

void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => Controller())
      ],
      child:
    MaterialApp(home: ChangeNotifierProvider(
      create:(context) => Controller(),
     child:MyApp()))));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
