import 'package:flutter/material.dart';

class Navigation {
  const Navigation();

  void moveHomePage(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void moveAddPage(BuildContext context) {
    Navigator.pushNamed(context, '/add');
  }

  void moveEditPage(BuildContext context, String currentTile) {
    Navigator.of(context).pushNamed('/edit',
        arguments: currentTile);
  }
}
