import "package:flutter/material.dart";

class CupAddWidget extends StatelessWidget {
  late String cup;
  late String size;
  var onTap;
  var value;

  CupAddWidget({required this.cup, required this.size, required this.onTap, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Column(children: [
          Expanded(child: Image.asset("assets/images/$cup.png")),
          Container(height: 10),
          Text("${size}ml",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: value.darkMode ? Colors.white : const Color.fromARGB(255, 94, 94, 94),
              )),
        ]),
      ),
    );
  }
}
