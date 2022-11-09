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
          value.history.add(value.sizes[index]);
          value.addCup();
          Navigator.pop(context);
        },
        child: Column(children: [
          Expanded(child: Image.asset("assets/images/$cup.png")),
          Container(height: 10),
          Text(size),
        ]),
      ),
    );
  }
}
