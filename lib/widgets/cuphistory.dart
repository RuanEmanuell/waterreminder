import 'package:water_reminder/controller/controller.dart';
import 'package:water_reminder/models/languages.dart';
import 'package:flutter/material.dart';

class CupHistoryWidget extends StatelessWidget {
  final int index;
  final Controller value;
  final bool removeButtonVisible;
  final bool removeDialog;
  const CupHistoryWidget({super.key, 
    required this.index,
    required this.value,
    required this.removeButtonVisible, 
    required this.removeDialog,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () async {
        bool remove = false;
        if(removeDialog){
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              title: Container(
                color: value.darkMode? const Color.fromARGB(255, 17, 17, 17) : Colors.white,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(value.english ? english[17] : portuguese[17], style: TextStyle(color: value.darkMode? Colors.white:Colors.black),),
                ),
              ),
              content: Container(
                color: value.darkMode? const Color.fromARGB(255, 17, 17, 17) : Colors.white,
                padding: EdgeInsets.all(20),
                height: screenHeight / 3.5,
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
                        removeDialog: false,
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
                              child: Text(value.english ? english[18] : portuguese[18],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            remove = true;
                          },
                        ),
                        SizedBox(width: screenWidth / 25),
                        InkWell(
                          child: Container(
                            height: screenHeight / 15,
                            width: screenWidth / 5,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(value.english ? english[19] : portuguese[19],
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
        }
        if(remove){
        value.removeCup(index);
        value.createBannerAd();
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
