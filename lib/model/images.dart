import 'dart:math';

class Images {
  Images();
  List<String> imagePathes = [
    "images/add_background.jpg",
    "images/add_background2.jpg",
  ];

  String getImagePath() {
    final random = Random();
    int randomIndex = random.nextInt(imagePathes.length);
    return imagePathes[randomIndex];
  }
}
