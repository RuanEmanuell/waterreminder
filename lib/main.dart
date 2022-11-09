import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'controller/controller.dart';

import "widgets/appbar.dart";
import "screens/home.dart";
import "screens/history.dart";
import "screens/add.dart";

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())],
      child:
          MaterialApp(home: ChangeNotifierProvider(create: (context) => Controller(), child: MyApp()))));
}

class MyApp extends StatelessWidget {
  var controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
            child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  if (value.percentage < 100) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AddScreen(value: value);
                      },
                    ));
                  }
                },
                backgroundColor: value.size >= 0.7 ? Colors.blue : Colors.white,
                child: Icon(Icons.add, size: 30, color: value.size >= 0.7 ? Colors.white : Colors.blue)),
          );
        }));
  }
}
