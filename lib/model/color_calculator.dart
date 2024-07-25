import 'package:flutter/material.dart';

class ColorCalulater {
  final List<Color> colors;
  const ColorCalulater({required this.colors});

  Color getTileColor(int index) {
    return colors[index % colors.length];
  }

  Color getComplementaryColor(Color color) {
    int red = 255 - color.red;
    int green = 255 - color.green;
    int blue = 255 - color.blue;

    return Color.fromARGB(color.alpha, red, green, blue);
  }
}
