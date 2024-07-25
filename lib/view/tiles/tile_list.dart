import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Color color;
  final String documentId;
  final String title;
  const Tile(
      {super.key,
      required this.title,
      required this.documentId,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 30, 10),
        child: ListTile(
          leading: const Icon(Icons.phone_android),
          tileColor: color,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}
