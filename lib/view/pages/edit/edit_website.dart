import 'package:flutter/material.dart';
import 'package:shake_open_website/controller/edit_page_controller.dart';
import 'package:shake_open_website/model/navigation.dart';

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
              if (favorite) {
                await showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("このサイトを「シェイクで開く」設定にしますか？"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text("はい")),
                        TextButton(
                            onPressed: () {
                              favorite = false;
                              Navigator.pop(context);
                            },
                            child: const Text("いいえ")),
                      ],
                    );
                  },
                );
              }
              await EditPageController(
                      documentId: widget.currenTile.split('+')[0],
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
