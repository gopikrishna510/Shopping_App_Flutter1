import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app_flutter/Pages/forgetpassword.dart';
import 'package:shopping_app_flutter/Pages/homepage.dart';
import 'package:shopping_app_flutter/Pages/registrationform.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var size, height, width;

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    //check_if_already_login();
  }

  /*void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SplashScreen()));
    }
  }*/
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /*void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }*/

  /* bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
 late bool checkWeb;
  if(Platform.isAndroid){

  }*/
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return MaterialApp(
        color: Colors.red,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          /* appBar: kIsWeb
            ? appBarCustomForWeb(context)
            : appBarCustomForAndroid(context),*/
          body: kIsWeb
              ? loginPageCustomForWeb(context)
              : loginPageCustomForAndroid(context),
        ));
  }

  PreferredSize appBarCustomForAndroid(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(300.0),
      child: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
          ),
        ),
        /*leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.account_circle_rounded, color: Colors.black),
          //   color: Theme.of(context).primaryColor,
        ),*/
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
      ),
    );
  }

  AppBar? appBarCustomForWeb(BuildContext context) {
    return null;
  }

  Widget loginPageCustomForAndroid(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width:width,
          height: height,
          child: Column(
            children: [
              Container(
                  width: width,
                  height: height / 2.6,
                  decoration: const BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100))),
                  alignment: Alignment.bottomRight,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Image.asset(
                              'assets/images/hamburger_login_image.png',
                              width: 140),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 220),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                /*const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text("Login",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),*/
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined,
                              color: Colors.black12),
                          focusColor: Colors.red,
                          /*border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30))),*/
                          //border: OutlineInputBorder(),
                          //labelText: 'User Name',
                          //errorText: "",
                          hintText: 'Enter User Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextField(
                        controller: passwordController,
                        //hiding text that used for password
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded,
                              color: Colors.black12),
                          focusColor: Colors.red,
                          /* border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),*/
                          // labelText: 'Password',
                          //errorText: "",
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0),
                      child: FlatButton(
                        textColor: Colors.black,
                        child: const Text(
                          'Forgot Password ?',
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ));
                        },
                      ),
                    ),
                    Container(
                      width: 290,
                      margin: const EdgeInsets.only(top: 50.0),
                      padding: const EdgeInsets.all(0.0),
                      decoration: const BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: FlatButton(
                        padding: const EdgeInsets.all(10),
                        textColor: Colors.white,
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          if (username != '' && password != '') {
                            print('Successful');
                            /*  logindata.setBool('login', false);
                            logindata.setString('username', username);*/
                            print(username);
                            //print(password);
                            //callSharedPref(username);
                            login();
                            /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(title: username),
                          ),
                        );*/
                            // _navigateToNextScreen(context);
                            /* Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const HomePage()));*/
                          }
                          else{
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Black Field Not Allowed")));
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 77.0, left: 0),
                          child: const Text(
                            "Don't have an account ?",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 77.0, left: 0),
                          margin: const EdgeInsets.only(right: 0, left: 0),
                          /* child: FlatButton(
                        textColor: Colors.red,
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                      ),*/

                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(1.0),
                              primary: Colors.red,
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegistrationForm(),
                                ),
                              );
                            },
                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget loginPageCustomForWeb(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login1.jpg"),
                fit: BoxFit.cover)),
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60, bottom: 60),
              child: const Text('My Account', style: TextStyle(fontSize: 25)),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 300,
                child: Column(
                  children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 0),
                        child: Icon(
                          Icons.person_pin,
                          size: 130,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined,
                              color: Colors.black54),
                          focusColor: Colors.red,
                          // border: OutlineInputBorder(),
                          //labelText: 'Login',
                          //errorText: "",
                          hintText: 'Enter User_name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded,
                              color: Colors.black54),
                          focusColor: Colors.red,
                          // border: OutlineInputBorder(),
                          //labelText: 'Login',
                          //errorText: "",
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 130),
                      margin: const EdgeInsets.only(right: 0, left: 0),
                      child: FlatButton(
                        textColor: Colors.black54,
                        child: const Text(
                          'Forget Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ));
                        },
                      ),
                    ),
                    Container(
                      width: 290,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(Radius.zero)),
                      child: FlatButton(
                        padding: const EdgeInsets.all(10),
                        textColor: Colors.white,
                        child: const Text('Login'),
                        onPressed: () {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          if (username != '' && password != '') {
                            print('Successful');
                            /*  logindata.setBool('login', false);
                            logindata.setString('username', username);*/
                            //print(username);
                            //print(password);
                            //callSharedPref(username);
                            login();
                          /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(title: username),
                              ),
                            );*/
                            //  _navigateToNextScreen(context);
                            /* Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const HomePage()));*/
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15.0, left: 0),
                  child: const Text(
                    "Don't have an account ?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15.0, left: 0),
                  margin: const EdgeInsets.only(right: 0, left: 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(1.0),
                      primary: Colors.red,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {},
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //setting up the shared preferences
  Future<void> callSharedPref(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    prefs.setString('title', title);
  }

  //CREATE FUNCITON TO CALL LOGIN POST API
  Future<void> login() async {
    if (passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: ({
            'email': usernameController.text,
            'password': passwordController.text
          }));
      print("status code ${response.statusCode}");
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(title: usernameController.text)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid Credentials."),),);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Black Field Not Allowed"),),);
    }
  }
}
