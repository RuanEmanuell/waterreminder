import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';


class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Consumer<Controller>(
            builder: (context, value, child) {
              return Column(
                children: const [Text("Hello Flutter!")],
              );
            },
          )),
    );
  }
}
