import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/constants.dart';
import '../components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool _passwordVisible = false;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorhandle = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: whitePrimary,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: kPrimaryColor,
          body: Container(
            color: whitePrimary,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: generalPadding, right: generalPadding),
                          width: width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Movie Assignment',
                                  style: TextStyle(
                                      fontSize: extraFontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: generalPadding),
                                  child: Text(
                                    'login with email to start watching movie',
                                    style: TextStyle(
                                      fontSize: generalFontSize,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'new here?',
                                        style: TextStyle(
                                          fontSize: generalFontSize,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () =>
                                              Get.toNamed('/register/'),
                                          child: Text(
                                            'create an account',
                                            style: TextStyle(
                                                fontSize: generalFontSize,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: purplePrimary,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ),
                              ])),
                      Padding(
                        padding: EdgeInsets.only(
                            left: generalPadding, right: generalPadding),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: greyPrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle:
                                      TextStyle(fontSize: generalFontSize),
                                  border: InputBorder.none),
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: 10,
                              left: generalPadding,
                              right: generalPadding),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: width,
                          height: generalHightButton,
                          decoration: BoxDecoration(
                            color: greyPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(fontSize: generalFontSize),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none),
                          )),
                      errorhandle != ''
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPadding,
                                  left: generalPadding,
                                  right: generalPadding),
                              child: Text(
                                errorhandle,
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.all(generalPadding),
                        child: Button(
                            width: width,
                            color: purplePrimary,
                            textColor: whitePrimary,
                            fontsize: generalFontSize,
                            onPress: () async {
                              try {
                                Utils.showAlertDialog(context);
                                final User? firebaseUser = (await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text))
                                    .user;
                                if (firebaseUser != null) {
                                  Get.offAllNamed('/landing');
                                } else {
                                  print('Check email and password');
                                }
                              } on FirebaseAuthException catch (e) {
                                Navigator.pop(context);
                                setState(() {
                                  errorhandle = e.message!;
                                });
                              }
                            },
                            title: 'Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
