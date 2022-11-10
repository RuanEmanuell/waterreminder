import "package:flutter/material.dart";

class CupHistoryWidget extends StatelessWidget {
  var index;
  var value;
  CupHistoryWidget({required this.index, required this.value});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 5, right: 5),
            height: screenHeight / 20,
            child: Image.asset("assets/images/${value.list0[index]}.png")),
        Expanded(
          child: Text("${value.list1[index]}ml",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: value.darkMode ? Colors.white : Colors.grey)),
        ),
        const SizedBox(width: 5),
        Text(value.list2[index],
            style: TextStyle(
                fontWeight: FontWeight.bold, color: value.darkMode ? Colors.white : Colors.grey)),
      ],
    );
  }
}
