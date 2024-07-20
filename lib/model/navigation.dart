import 'package:flutter/material.dart';

class Navigation {
  const Navigation();

  void moveAddPage(BuildContext context) {
    Navigator.pushNamed(context, '/add');
  }

  void moveEditPage(BuildContext context, String documentId) {
    Navigator.of(context).pushNamed('/edit', arguments: documentId);
  }
}
