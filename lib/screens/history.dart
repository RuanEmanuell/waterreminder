import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

import "add.dart";

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Consumer<Controller>(
              builder: (context, value, child) {
                return value.history.isEmpty
                    ? Column(
                        children: [
                          const Text("It looks like you still don't have drink water today...",
                              style: TextStyle(color: Color.fromARGB(255, 80, 80, 80))),
                          const SizedBox(height: 10),
                          FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AddScreen(value: value);
                                  },
                                ));
                              },
                              child: const Icon(Icons.add, size: 30))
                        ],
                      )
                    : SizedBox(
                        height: screenHeight,
                        child: ListView.builder(
                          itemCount: value.history.length,
                          itemBuilder: (context, index) {
                            return Text(value.history[index]);
                          },
                        ),
                      );
              },
            )),
      ),
    );
  }
}
