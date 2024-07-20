import 'package:cloud_firestore/cloud_firestore.dart';

class AddPageController {
  const AddPageController(
      {required this.title, required this.url, required this.favorite});
  final String title;
  final String url;
  final bool favorite;

  Future<void> addSite() async {
    await FirebaseFirestore.instance
        .collection('website')
        .add({'title': title, 'url': url, 'favorite': favorite});
  }
}
