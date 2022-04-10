// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app_flutter/Pages/homepage.dart';
import 'package:shopping_app_flutter/Pages/loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool newLaunch;

  resetNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("newLaunch")) {
      prefs.setBool('newLaunch', false);
    } else {
      prefs.setBool('newLaunch', false);
    }
  }

  loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool _newLaunch = ((prefs.getBool('newLaunch') ?? true));
      newLaunch = _newLaunch;
    });
  }

  getStringValuesSP() async {

 try{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   //Return String
   String? stringValue = prefs.getString('title');
   title = stringValue;
   print('Welcome----->' + title);
   return stringValue;
 // ignore: empty_catches
 }on Exception catch(e){
  print(e);
 }
  }

  var title;

  //the about title returning null so,to checking for user might refresh the page it's opening the HomePage so make user safety  i make like this
  Widget checkForNullValues(BuildContext context) {
    if (title == null) {
      return const LoginPage();
    } else {
      return HomePage(title: title);
    }
  }

  @override
  void initState() {
    super.initState();
    loadNewLaunch();
    getStringValuesSP();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              resetNewLaunch();
              return newLaunch
                  ? const LoginPage()
                  : checkForNullValues(context);
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              kIsWeb
                  ? Text('Splash_Screen_Web',
                      style: TextStyle(color: Colors.white, fontSize: 40))
                  : Text('SplashScreen_Android ',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
