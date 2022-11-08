import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import "package:wave/wave.dart";

import "../controller/controller.dart";

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body:SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Consumer<Controller>(
          builder:(context, value, child) {
            return Column(
              children: [
                Container(height: screenHeight/2.5, child:ElevatedButton(
                  onPressed:(){
                    value.big=!value.big;
                    value.notifyListeners();
                  },
                  child:Text("Big")
                )),
                WaveWidget(size: Size(screenWidth, screenHeight),
                  config: CustomConfig(
                    gradients:[
                      [Color.fromARGB(255, 10, 110, 192), Colors.lightBlue],
                      [Colors.blue, Colors.lightBlue],       
                    ],
                    heightPercentages: [value.big ? 0.1: 0.5, value.big ? 0.1:0.5],
                    durations:[
                      5000,
                      6000
                    ]
                  ),
      
                )
      
              ],
            );
          },
        ),
      )
    );
  }
}