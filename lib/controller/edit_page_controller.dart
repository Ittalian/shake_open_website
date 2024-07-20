import 'package:cloud_firestore/cloud_firestore.dart';

class EditPageController {
  const EditPageController(
      {required this.documentId,
      required this.title,
      required this.url,
      required this.favorite});
  final String documentId;
  final String title;
  final String url;
  final bool favorite;

  Future<void> editSite() async {
    await FirebaseFirestore.instance
        .collection('website')
        .doc(documentId)
        .set({'title': title, 'url': url, 'favorite': favorite});
  }
}
