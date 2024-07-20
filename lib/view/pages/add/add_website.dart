import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/add_page_controller.dart';

class AddWebsite extends StatefulWidget {
  const AddWebsite({super.key});

  @override
  State<AddWebsite> createState() => _AddWebsite();
}

class _AddWebsite extends State<AddWebsite> {
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
            onPressed: AddPageController(title: title, url: url, favorite: favorite).addSite,
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
