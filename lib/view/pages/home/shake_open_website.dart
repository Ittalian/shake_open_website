import 'package:flutter/material.dart';
import 'package:shake_open_website/view/pages/add/add_website.dart';
import 'package:shake_open_website/view/pages/edit/edit_website.dart';
import 'package:shake_open_website/view/pages/home/shake_open_website_widget.dart';

class ShakeOpenWebsite extends StatelessWidget {
  const ShakeOpenWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const ShakeOpenWebsiteWidget(),
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
