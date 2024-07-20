import 'package:cloud_firestore/cloud_firestore.dart';

class DeletePageController {
  const DeletePageController({required this.documentId});
  final String documentId;

  Future<void> deleteTile(String documentId) async {
    await FirebaseFirestore.instance
        .collection('website')
        .doc(documentId)
        .delete();
  }
}
