import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shake_open_website/add_website.dart';
import 'package:shake_open_website/edit_website.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyWidget(),
        '/add': (context) => const AddWebsite(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          return MaterialPageRoute(
              builder: (context) =>
                  EditWebsite(documentId: settings.arguments.toString()));
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String favoriteTitle = '';

  void moveAddPage() {
    Navigator.pushNamed(context, '/add');
  }

  void moveEditPage(String documentId) {
    Navigator.of(context).pushNamed('/edit', arguments: documentId);
  }

  Future<void> deletePage(String documentId) async {
    await FirebaseFirestore.instance
        .collection('website')
        .doc(documentId)
        .delete();
  }

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
        ListTile(
          tileColor: Colors.blueGrey,
          title: Container(
              alignment: Alignment.topCenter,
              child: Text(
                favoriteTitle,
                style: const TextStyle(fontSize: 20),
              )),
        ),
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
                  return ListTile(
                    tileColor: getTileColor(index),
                    title: Row(children: [
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            reverseList[index][0],
                            style: const TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () => moveEditPage(reverseList[index][3]),
                          child: const Text(
                            "編集",
                            style: TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () => deletePage(reverseList[index][3]),
                          child: const Text(
                            "削除",
                            style: TextStyle(fontSize: 20),
                          )),
                    ]),
                  );
                },
              );
            },
          ),
        )),
        ElevatedButton(
            onPressed: moveAddPage,
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
