import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shake_open_website/add_website.dart';

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
  void moveAddPage() {
    Navigator.pushNamed(context, '/add');
  }

  Color getTileColor(int index) {
    switch (index % 2) {
      case 0:
        return Colors.white;
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
              height: double.infinity,
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
                        title: Container(
                            alignment: Alignment.center,
                            child: Text(
                              reverseList[index][0],
                              style: const TextStyle(fontSize: 20),
                            )),
                      );
                    },
                  );
                },
              )),
        ),
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
