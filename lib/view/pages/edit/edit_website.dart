import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/edit_page_controller.dart';
import 'package:shake_open_website/model/navigation.dart';

class EditWebsite extends StatefulWidget {
  final String documentId;
  const EditWebsite({super.key, required this.documentId});

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
            onPressed: () {
              EditPageController(
                      documentId: widget.documentId,
                      title: title,
                      url: url,
                      favorite: favorite)
                  .editSite();
              const Navigation().moveHomePage(context);
            },
            child: const Text(
              '編集',
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
