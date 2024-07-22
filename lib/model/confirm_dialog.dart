import 'package:flutter/material.dart';

class ConfirmDialog {
  const ConfirmDialog();

  Future<bool> show(BuildContext context, bool favorite) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("このサイトを「シェイクで開く」設定にしますか？"),
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
}
