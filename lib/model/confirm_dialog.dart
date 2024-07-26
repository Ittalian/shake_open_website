import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/delete_page_controller.dart';
import 'package:shake_open_website/model/base_dailog.dart';
import 'package:shake_open_website/model/message.dart';

class ConfirmDialog {
  const ConfirmDialog();

  Future<bool> show(BuildContext context, String title, String subTitle,
      bool favorite) async {
    await showDialog(
      context: context,
      builder: (context) => BaseDailog(
          title: title,
          subTitle: subTitle,
          trueFunction: () => favorite = true,
          falseFunction: () => favorite = false),
    );
    return favorite;
  }

  Future<void> showDelete(BuildContext context, String title, String subTitle,
      String documentId) async {
    await showDialog(
      context: context,
      builder: (context) => BaseDailog(
          title: title,
          subTitle: subTitle,
          trueFunction: () => _delete(context, documentId),
          falseFunction: () {}),
    );
  }

  void _delete(BuildContext context, String documentId) {
    DeletePageController(documentId: documentId).deleteTile();
    const Message().informChange(context, '削除しました');
  }
}
