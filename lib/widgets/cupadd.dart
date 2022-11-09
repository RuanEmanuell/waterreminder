import "package:flutter/material.dart";

class CupAddWidget extends StatelessWidget {
  late String cup;
  late String size;
  var onTap;

  CupAddWidget({required this.cup, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Column(children: [
          Expanded(child: Image.asset("assets/images/$cup.png")),
          Container(height: 10),
          Text("${size}ml"),
        ]),
      ),
    );
  }
}
