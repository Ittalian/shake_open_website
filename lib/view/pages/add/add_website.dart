import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/add_page_controller.dart';
import 'package:shake_open_website/model/confirm_dialog.dart';
import 'package:shake_open_website/model/database.dart';
import 'package:shake_open_website/model/message.dart';
import 'package:shake_open_website/model/navigation.dart';

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
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/add_background.jpg'),
              fit: BoxFit.cover,
            )),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    onPressed: () async {
                      favorite = await const ConfirmDialog()
                          .show(context, "このサイトを「シェイクで開く」設定にしますか？", favorite);
                      if (favorite) {
                        await const Database().turnFalseCurrentFavorite();
                      }
                      AddPageController(
                              title: title, url: url, favorite: favorite)
                          .addSite();
                      const Message().informChange(context, '登録しました');
                      const Navigation().moveHomePage(context);
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
