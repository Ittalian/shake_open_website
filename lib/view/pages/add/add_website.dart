import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/add_page_controller.dart';
import 'package:shake_open_website/model/confirm_dialog.dart';
import 'package:shake_open_website/model/database.dart';
import 'package:shake_open_website/model/images.dart';
import 'package:shake_open_website/model/message.dart';
import 'package:shake_open_website/model/navigation.dart';
import 'package:shake_open_website/model/validator.dart';

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
    String imagePath = Images().getImagePath();
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            )),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Material(
                          child: TextFormField(
                        controller: titleController,
                        validator: (value) =>
                            Validator(value: value).validateTitle(),
                        onChanged: setTitle,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          hintText: '例',
                          labelText: 'タイトル',
                        ),
                      ))),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Material(
                          child: TextFormField(
                        controller: urlController,
                        validator: (value) =>
                            Validator(value: value).validateUrl(),
                        onChanged: setUrl,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.link),
                          hintText: 'https://example.com',
                          labelText: 'URL',
                        ),
                      ))),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        favorite = await const ConfirmDialog().show(context,
                            "シェイクで開く", "このサイトを「シェイクで開く」設定にしますか？", favorite);
                        if (favorite) {
                          await const Database().turnFalseCurrentFavorite();
                        }
                        AddPageController(
                                title: title, url: url, favorite: favorite)
                            .addSite();
                        const Message().informChange(context, '登録しました');
                        const Navigation().moveHomePage(context);
                      }
                    },
                    child: const Text(
                      '追加',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                ],
              ),
            )));
  }
}
