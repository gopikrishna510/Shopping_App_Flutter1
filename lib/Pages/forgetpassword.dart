import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/Pages/resetpassword.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: formForgetPasswordCustomWidget(context),
      ),
    );
  }

  Widget formForgetPasswordCustomWidget(BuildContext context) {
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
              margin: const EdgeInsets.only(top: 150.0),
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
                        child: const Text('Forgot Password',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30.0, right: 25),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter username',
                          labelText: 'UserName',
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
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ),
                              );
                            }
                          },
                          child: const Text('Forgot Password'),
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
