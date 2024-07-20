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
        } catch (e) {
          favoriteTitle = "設定されていません";
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 50)),
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.center,
            child: const Text(
              "シェイクで開くサイト",
              style: TextStyle(fontSize: 20),
            )),
        Tilelist(title: favoriteTitle, color: Colors.blueGrey),
        SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.only(bottom: 30),
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
                final documentData = document.data()! as Map<String, dynamic>;
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
                  return ButtonTileList(reverseList: reverseList, index: index);
                },
              );
            },
          ),
        )),
        ElevatedButton(
            onPressed: () => const Navigation().moveAddPage(context),
            child: const Text(
              "追加",
              style: TextStyle(
                fontSize: 20,
              ),
            ))
      ],
    ));
  }
}
