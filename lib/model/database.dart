import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  const Database();

  Future<void> turnFalseCurrentFavorite() async {
    CollectionReference currentFavoriteCollection =
          FirebaseFirestore.instance.collection('website');
      Query currentFavoriteQuery =
          currentFavoriteCollection.where('favorite', isEqualTo: true);
      QuerySnapshot currentFavoriteSnapshot = await currentFavoriteQuery.get();

      for (QueryDocumentSnapshot doc in currentFavoriteSnapshot.docs) {
        String currentFavoriteId = doc.id;
        String currentFavoritetitle = doc['title'];
        String currentFavoriteUrl = doc['url'];
        await currentFavoriteCollection.doc(currentFavoriteId).set({
          'title': currentFavoritetitle,
          'url': currentFavoriteUrl,
          'favorite': false
        });
      }
  }
}
