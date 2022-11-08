import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

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
                return Column(
                  children: [
                    const Text("It looks like you still don't have drink water today...",
                        style: TextStyle(color: Color.fromARGB(255, 80, 80, 80))),
                    const SizedBox(height: 10),
                    FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add))
                  ],
                );
              },
            )),
      ),
    );
  }
}
