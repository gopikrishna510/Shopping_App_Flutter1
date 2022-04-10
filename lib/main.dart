import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app_flutter/Pages/splashscreen.dart';
import 'dart:io' show Platform;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shopping_App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
