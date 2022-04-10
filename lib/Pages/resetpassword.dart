import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/Pages/loginpage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: formResetPasswordCustomWidget(context),
      ),
    );
  }

  Widget formResetPasswordCustomWidget(BuildContext context) {
    return Container(
      width: 360,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login1.jpg"),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 310,
              margin: const EdgeInsets.only(top: 128.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0, left: 50),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text('Reset Password',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30.0, right: 25),
                      child: TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Enter new Password',
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter new Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30.0, right: 25),
                      child: TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: reEnterPasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Re-enter Password',
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.all(Radius.zero)),
                        child: FlatButton(
                          onPressed: () {
                            String newPassword = newPasswordController.text;
                            String reEnterPassword =
                                reEnterPasswordController.text;
                            if (_formKey.currentState!.validate() &&
                                newPassword == reEnterPassword) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                            /* else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ),
                              );

                            }*/
                          },
                          child: const Text('Reset Password'),
                          // It returns true if the form is valid, otherwise returns false
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
