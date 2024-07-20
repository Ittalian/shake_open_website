import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shake_open_website/view/pages/home/shake_open_website.dart';
import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ShakeOpenWebsite());
}
