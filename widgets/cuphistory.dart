import 'package:flutter/material.dart';

class CupHistoryWidget extends StatelessWidget {
  var index;
  var value;
  late bool removeButtonVisible;
  late bool removeDialog;
  CupHistoryWidget({
    required this.index,
    required this.value,
    required this.removeButtonVisible,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () async {
        bool remove = false;
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text("Deseja remover esse copo?"),
              ),
              content: Container(
                height: screenHeight / 4,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: CupHistoryWidget(
                        index: index,
                        value: value,
                        removeButtonVisible: false,
                      ),
                    ),
                    SizedBox(height: screenHeight / 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: screenHeight / 15,
                            width: screenWidth / 5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Sim",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            remove = true;
                          },
                        ),
                        SizedBox(width: screenWidth / 20),
                        InkWell(
                          child: Container(
                            height: screenHeight / 15,
                            width: screenWidth / 5,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Não",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        if(remove){
        value.removeCup(index);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5, right: 5),
              height: screenHeight / 20,
              child: Image.asset("assets/images/${value.list0[index]}.png"),
            ),
            Expanded(
              child: Text(
                "${value.list1[index]}ml",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: value.darkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 94, 94, 94),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Row(
              children: [
                Text(
                  value.list2[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: value.darkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 94, 94, 94),
                  ),
                ),
                const SizedBox(width: 10),
                 removeButtonVisible
                      ? Container(
                          height: screenHeight / 25,
                          width: screenWidth / 15,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Icon(Icons.close, color: Colors.white)),
                        )
                      : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
