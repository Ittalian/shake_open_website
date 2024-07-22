import 'package:cloud_firestore/cloud_firestore.dart';

class EditPageController {
  const EditPageController({
    required this.documentId,
    required this.title,
    required this.url,
    required this.favorite,
  });
  final String documentId;
  final String title;
  final String url;
  final bool favorite;

  Future<void> editSite() async {
    if (favorite) {
      CollectionReference currentFavoriteCollection =
          FirebaseFirestore.instance.collection('website');
      Query currentFavoriteQuery =
          currentFavoriteCollection.where('favorite', isEqualTo: true);
      QuerySnapshot currentFavoriteSnapshot = await currentFavoriteQuery.get();

      for (QueryDocumentSnapshot doc in currentFavoriteSnapshot.docs) {
        String currentFavoriteId = doc.id;
        String currentFavoritetitle = doc['title'];
        String currentFavoriteUrl = doc['url'];
        await currentFavoriteCollection
            .doc(currentFavoriteId)
            .set({'title': currentFavoritetitle, 'url': currentFavoriteUrl, 'favorite': false});
      }
    }
    await FirebaseFirestore.instance
        .collection('website')
        .doc(documentId)
        .set({'title': title, 'url': url, 'favorite': favorite});
  }
}
