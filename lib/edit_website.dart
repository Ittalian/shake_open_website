import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditWebsite extends StatefulWidget {
  const EditWebsite({super.key});

  @override
  State<EditWebsite> createState() => _EditWebsite();
}

class _EditWebsite extends State<EditWebsite> {
  final titleController = TextEditingController();
  final urlController = TextEditingController();
  String title = '';
  String url = '';
  bool favorite = false;
  final formKey = GlobalKey<FormState>();

  void setTitle(String value) {
    setState(() {
      title = value;
    });
  }

  void setUrl(String value) {
    setState(() {
      url = value;
    });
  }

  Future<void> addSite() async {
    await FirebaseFirestore.instance
        .collection('website')
        .add({'title': title, 'url': url, 'favorite': favorite});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
          ),
          Material(
              child: TextFormField(
            controller: titleController,
            onChanged: setTitle,
          )),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Material(
              child: TextFormField(
            controller: urlController,
            onChanged: setUrl,
          )),
          ElevatedButton(
            onPressed: addSite,
            child: const Text(
              '追加',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
