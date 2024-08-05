import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/edit_page_controller.dart';
import 'package:shake_open_website/model/confirm_dialog.dart';
import 'package:shake_open_website/model/images.dart';
import 'package:shake_open_website/model/message.dart';
import 'package:shake_open_website/model/navigation.dart';
import 'package:shake_open_website/model/validator.dart';

class EditWebsite extends StatefulWidget {
  final String currenTile;
  const EditWebsite({super.key, required this.currenTile});

  @override
  State<EditWebsite> createState() => _EditWebsite();
}

class _EditWebsite extends State<EditWebsite> {
  List<String> currentTileList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  String title = '';
  String url = '';
  bool favorite = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentTileList = widget.currenTile.split('+');
    titleController = TextEditingController(text: currentTileList[1]);
    urlController = TextEditingController(text: currentTileList[2]);
    title = currentTileList[1];
    url = currentTileList[2];
  }

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

  void setFavorite(bool? value) {
    setState(() {
      favorite = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = Images().getEditImagePath();
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            )),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                      child: Material(
                          child: TextFormField(
                        controller: titleController,
                        validator: (value) =>
                            Validator(value: value).validateTitle(),
                        onChanged: setTitle,
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
                      ))),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "シェイクで開く",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 20)),
                      Checkbox(value: favorite, onChanged: setFavorite)
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (favorite) {
                          favorite = await const ConfirmDialog().show(context,
                              "シェイクで開く", "このサイトを「シェイクで開く」設定にしますか？", favorite);
                        }
                        await EditPageController(
                                documentId: widget.currenTile.split('+')[0],
                                title: title,
                                url: url,
                                favorite: favorite)
                            .editSite();
                        const Message().informChange(context, '編集しました');
                        const Navigation().moveHomePage(context);
                      }
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
            )));
  }
}
