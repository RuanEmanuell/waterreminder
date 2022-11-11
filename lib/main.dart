import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:hive_flutter/hive_flutter.dart";

import 'screens/controller/controller.dart';

import 'screens/widgets/appbar.dart';
import 'screens/widgets/mainbutton.dart';

import 'screens/screens/home.dart';
import 'screens/screens/history.dart';

void main() async {
  await Hive.initFlutter();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())],
      child: MaterialApp(home: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var controller = PageController(initialPage: 0);
  var data;

  @override
  void initState() {
    super.initState();
    
    data=Provider.of<Controller>(context, listen: false);

    data.openBox();

    Future.delayed(const Duration(seconds: 1), () {
      if (Hive.box("box0").get("list0") == null) {
        data.createData();
      } else {
        data.loadData();
        data.defaultPercentageSize();
      }

      data.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 12),
            child: CustomAppBar(controller: controller)),
        body: Consumer<Controller>(builder: (context, value, child) {
          return Container(
            color: value.white,
            child: value.loading
                ? const Center(child: CircularProgressIndicator())
                : PageView(
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
                      value.changeAppBarColor();
                    },
                    children: [HomeScreen(), HistoryScreen()]),
          );
        }),
        floatingActionButton: Consumer<Controller>(builder: (context, value, child) {
          return AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: value.page == 0 ? 1 : 0,
              child: MainButton(value: value, heroTag: "btn1"));
        }));
  }
}
