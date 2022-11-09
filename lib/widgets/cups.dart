import "package:flutter/material.dart";

class CupWidget extends StatelessWidget {
  late String cup;
  late String size;
  late var index;
  var value;

  CupWidget({required this.cup, required this.size, required this.index, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          var hour = DateTime.now().hour;
          var minute = DateTime.now().minute;

          value.history[0].add(value.cups[1][index]);
          value.history[1].add(value.cups[0][index]);

          if (minute < 10) {
            value.history[2].add("$hour:0$minute");
          } else if (hour < 10) {
            value.history[2].add("0$hour:$minute");
          } else {
            value.history[2].add("$hour:$minute");
          }

          value.cupSize = int.parse(value.cups[1][index]);

          value.addCup();

          value.increaseWater();

          Navigator.pop(context);
        },
        child: Column(children: [
          Expanded(child: Image.asset("assets/images/$cup.png")),
          Container(height: 10),
          Text("${size}ml"),
        ]),
      ),
    );
  }
}
