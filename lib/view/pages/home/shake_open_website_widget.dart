import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shake_open_website/model/navigation.dart';
import 'package:shake_open_website/view/tiles/button_tile_list.dart';
import 'package:shake_open_website/view/tiles/tile_list.dart';

class ShakeOpenWebsiteWidget extends StatefulWidget {
  const ShakeOpenWebsiteWidget({super.key});

  @override
  State<ShakeOpenWebsiteWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ShakeOpenWebsiteWidget> {
  String favoriteTitle = '';
  String documentId = '';

  Color getTileColor(int index) {
    switch (index % 2) {
      case 0:
        return Colors.tealAccent;
      default:
        return Colors.grey;
    }
  }

  String storeFavorite(String favorite) {
    if (favorite == "true") {
      return "お気に入り";
    } else {
      return "リスト";
    }
  }

  Query<Map<String, dynamic>> getFavoritableSnapShot(bool favorite) {
    return FirebaseFirestore.instance
        .collection('website')
        .where('favorite', isEqualTo: favorite);
  }

  @override
  void initState() {
    getFavoritableSnapShot(true).get().then((QuerySnapshot snapshot) {
      setState(() {
        try {
          favoriteTitle = snapshot.docs.first['title'];
          documentId = snapshot.docs.first.id;
        } catch (e) {
          favoriteTitle = "設定されていません";
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/home_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  child: const Text(
                    "シェイクで開くサイト",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Tilelist(
                  title: favoriteTitle,
                  color: Colors.blueGrey,
                  documentId: documentId),
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: const Text(
                    "登録済みサイト",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              SingleChildScrollView(
                  child: Container(
                alignment: Alignment.topCenter,
                child: StreamBuilder<QuerySnapshot>(
                  stream: getFavoritableSnapShot(false).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('エラーが発生しました');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final list = snapshot.requireData.docs
                        .map<List<String>>((DocumentSnapshot document) {
                      final documentData =
                          document.data()! as Map<String, dynamic>;
                      return [
                        documentData['title']! as String,
                        documentData['favorite']!.toString(),
                        documentData['url']!.toString(),
                        document.id,
                      ];
                    }).toList();

                    final reverseList = list.reversed.toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reverseList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ButtonTileList(
                            reverseList: reverseList, index: index);
                      },
                    );
                  },
                ),
              )),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
                onPressed: () => const Navigation().moveAddPage(context),
                child: const Text(
                  "追加",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
          ),
        ));
  }
}
