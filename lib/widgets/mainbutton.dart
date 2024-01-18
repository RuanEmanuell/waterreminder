import "package:water_reminder/controller/controller.dart";
import "package:flutter/material.dart";


class MainButton extends StatelessWidget {
  final Controller value;
  final String heroTag;
  final IconData icon;
  final void Function() onPressed;

  const MainButton({super.key, required this.value, required this.heroTag, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: value.darkMode
            ? const Color.fromARGB(255, 0, 84, 153)
            : const Color.fromARGB(255, 94, 94, 94),
        child: Icon(icon, size: 30, color: Colors.white));
  }
}
