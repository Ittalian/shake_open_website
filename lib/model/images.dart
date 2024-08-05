import 'dart:math';

class Images {
  Images();
  List<String> homeImagePathes = [
    "images/home_background.png",
    "images/home_background2.png",
  ];

  List<String> addImagePathes = [
    "images/add_background.png",
    "images/add_background2.png",
  ];

  List<String> editImagePathes = [
    "images/edit_background.png",
    "images/edit_background2.png",
  ];

  String getHomeImagePath() {
    return getImagePath(homeImagePathes);
  }

  String getAddImagePath() {
    return getImagePath(addImagePathes);
  }

  String getEditImagePath() {
    return getImagePath(editImagePathes);
  }

  String getImagePath(List<String> imagePathes) {
    final random = Random();
    int randomIndex = random.nextInt(imagePathes.length);
    return imagePathes[randomIndex];
  }
}
