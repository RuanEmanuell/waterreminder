import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'controller/controller.dart';

import "widgets/appbar.dart";
import "widgets/mainbutton.dart";

import "screens/home.dart";
import "screens/history.dart";

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())],
      child: MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  var controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 12),
            child: CustomAppBar(controller: controller)),
        body: Consumer<Controller>(builder: (context, value, child) {
          return PageView(
              controller: controller,
              onPageChanged: (page) {
                switch (page) {
                  case 0:
                    value.page = 0;
                    break;
                  case 1:
                    value.page = 1;
                    break;
                  case 2:
                    value.page = 2;
                    break;
                }
                value.changeColor();
              },
              children: [HomeScreen(), HistoryScreen()]);
        }),
        floatingActionButton: Consumer<Controller>(builder: (context, value, child) {
          return AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: value.page == 0 ? 1 : 0,
              child: MainButton(value: value, heroTag: "btn1"));
        }));
  }
}
