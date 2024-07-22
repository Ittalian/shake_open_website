import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/delete_page_controller.dart';
import 'package:shake_open_website/model/message.dart';

class ConfirmDialog {
  const ConfirmDialog();

  Future<bool> show(BuildContext context, String text, bool favorite) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  favorite = true;
                  Navigator.pop(context);
                },
                child: const Text("はい")),
            TextButton(
                onPressed: () {
                  favorite = false;
                  Navigator.pop(context);
                },
                child: const Text("いいえ")),
          ],
        );
      },
    );
    return favorite;
  }

  Future<void> showDelete(BuildContext context, String text, String documentId) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await DeletePageController(documentId: documentId).deleteTile();
                  const Message().informChange(context, '削除しました');
                  Navigator.pop(context);
                },
                child: const Text("はい")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("いいえ")),
          ],
        );
      },
    );
  }
}
