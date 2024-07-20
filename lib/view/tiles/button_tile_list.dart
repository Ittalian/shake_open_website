import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/delete_page_controller.dart';
import 'package:shake_open_website/model/navigation.dart';

class ButtonTileList extends StatelessWidget {
  final List<List<String>> reverseList;
  final int index;
  const ButtonTileList({super.key, required this.reverseList, required this.index});

  Color getTileColor(int index) {
    switch (index % 2) {
      case 0:
        return Colors.tealAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: getTileColor(index),
      title: Row(children: [
        Container(
            alignment: Alignment.center,
            child: Text(
              reverseList[index][0],
              style: const TextStyle(fontSize: 20),
            )),
        ElevatedButton(
            onPressed: () =>
                const Navigation().moveEditPage(context, reverseList[index][3]),
            child: const Text(
              "編集",
              style: TextStyle(fontSize: 20),
            )),
        ElevatedButton(
            onPressed: () =>
                DeletePageController(documentId: reverseList[index][3]),
            child: const Text(
              "削除",
              style: TextStyle(fontSize: 20),
            )),
      ]),
    );
  }
}
