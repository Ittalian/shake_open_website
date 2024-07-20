import 'package:flutter/material.dart';

class Tilelist extends StatelessWidget {
  final Color color;
  final String title;
  const Tilelist({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color,
      title: Container(
          alignment: Alignment.topCenter,
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}
