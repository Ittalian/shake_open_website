import 'package:flutter/material.dart';
import 'package:shake_open_website/model/color_calculator.dart';
import 'package:shake_open_website/model/confirm_dialog.dart';
import 'package:shake_open_website/model/navigation.dart';

class ButtonTileList extends StatelessWidget {
  final List<List<String>> reverseList;
  final int index;
  const ButtonTileList(
      {super.key, required this.reverseList, required this.index});

  String insertLineBreaks(String input, int chunkSize) {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < input.length; i += chunkSize) {
      int end = (i + chunkSize < input.length) ? i + chunkSize : input.length;
      buffer.writeln(input.substring(i, end));
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      const Color(0xFFFF0000),
      const Color(0xFF00FF00),
      const Color(0xFF0000FF),
      const Color(0xFFFFFF00),
      const Color(0xFFFF00FF),
      const Color(0xFF00FFFF),
      const Color(0xFFFFA500),
      const Color(0xFF800080),
      Colors.tealAccent,
      Colors.black,
    ];

    ColorCalulater colorCalulater = ColorCalulater(colors: colors);

    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: ListTile(
          leading: const Icon(Icons.check_circle),
          tileColor: colorCalulater.getTileColor(index),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  insertLineBreaks(reverseList[index][0], 8),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorCalulater.getComplementaryColor(
                        colorCalulater.getTileColor(index)),
                  ),
                  onPressed: () => const Navigation().moveEditPage(context,
                      '${reverseList[index][3]}+${reverseList[index][0]}+${reverseList[index][2]}'),
                  child: const Text(
                    "編集",
                    style: TextStyle(fontSize: 20),
                  )),
              const Padding(padding: EdgeInsets.only(right: 10)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorCalulater.getComplementaryColor(
                        colorCalulater.getTileColor(index)),
                  ),
                  onPressed: () async {
                    await const ConfirmDialog().showDelete(
                        context, "本当に削除しますか？", reverseList[index][3]);
                  },
                  child: const Text(
                    "削除",
                    style: TextStyle(fontSize: 20),
                  ))
            ]),
          ]),
        ));
  }
}
