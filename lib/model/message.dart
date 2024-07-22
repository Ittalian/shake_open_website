import 'package:flutter/material.dart';

class Message {
  const Message();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> informChange(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    ));
  }
}
