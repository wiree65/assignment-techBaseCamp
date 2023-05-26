import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/login_screen.dart';

import '../components/button.dart';
import '../components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

showAlertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(purplePrimary)));
    },
  );
}

bool _passwordVisible = false;
bool _confirmPasswordVisible = false;

class _RegisterScreenState extends State<RegisterScreen> {
  var emailCheck = '';
  var passwordCheck = '';
  var confirmPasswordCheck = '';
  var errorhandle = '';

  bool passwordEqual = true;

  var emailCheckError = '';
  var passwordCheckError = '';
  var confirmPasswordCheckError = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstnameController = TextEditingController();

  final TextEditingController lastnameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void register() async {
    try {} catch (error) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
            color: whitePrimary,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: whitePrimary,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black54,
                    onPressed: () => Get.back(),
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: generalPaddingLeftRight,
                            top: generalPaddingTop),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Let’s get start',
                            style: TextStyle(
                                fontSize: extraFontSize,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: generalPaddingLeftRight,
                            top: generalPaddingTop),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Create an account to start watching movie',
                            style: TextStyle(
                              fontSize: generalFontSize,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: generalPaddingTop,
                            left: generalPaddingLeftRight,
                            right: generalPaddingLeftRight),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: width,
                            height: generalHightButton,
                            decoration: BoxDecoration(
                              color: greyPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  emailCheck = text;
                                  setState(() {
                                    errorhandle = '';
                                    emailCheckError = '';
                                  });
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle:
                                      TextStyle(fontSize: generalFontSize),
                                  border: InputBorder.none),
                            )),
                      ),
                      emailCheckError == 'error'
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPaddingLeftRight,
                                  left: generalPaddingLeftRight),
                              child: Text(
                                'โปรดใส่อีเมลบัญชีผู้ใช้',
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: generalPaddingLeftRight,
                            right: generalPaddingLeftRight),
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: generalPaddingTop),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: width,
                            height: generalHightButton,
                            decoration: BoxDecoration(
                              color: greyPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: (text) {
                                passwordCheck = text;
                                setState(() {
                                  passwordCheckError = '';
                                  errorhandle = '';
                                  passwordEqual = true;
                                });
                              },
                              controller: passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(fontSize: generalFontSize),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color.fromARGB(
                                          255, 121, 121, 121),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: generalPaddingLeftRight,
                            right: generalPaddingLeftRight),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: width,
                            height: generalHightButton,
                            decoration: BoxDecoration(
                              color: greyPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: (text) {
                                confirmPasswordCheck = text;
                                setState(() {
                                  confirmPasswordCheckError = '';
                                  passwordEqual = true;
                                  errorhandle = '';
                                });
                              },
                              controller: confirmPasswordController,
                              obscureText: !_confirmPasswordVisible,
                              decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Quicksand', fontSize: 15),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color.fromARGB(
                                          255, 121, 121, 121),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordEqual = true;
                                        _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none),
                            )),
                      ),
                      errorhandle != ''
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPaddingTop,
                                  left: generalPaddingLeftRight,
                                  right: generalPaddingLeftRight),
                              child: Text(
                                errorhandle,
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      emailCheck == 'error'
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPaddingTop,
                                  left: generalPaddingLeftRight),
                              child: Text(
                                'please fill in email',
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      passwordCheck == 'error'
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPaddingTop,
                                  left: generalPaddingLeftRight),
                              child: Text(
                                'please fill in password',
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      passwordEqual == false
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPaddingTop,
                                  left: generalPaddingLeftRight),
                              child: Text(
                                'password does not match',
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: generalPaddingTop,
                            left: generalPaddingLeftRight,
                            right: generalPaddingLeftRight),
                        child: Button(
                            width: width,
                            onPress: () {
                              Utils.showAlertDialog(context);
                              setState(() {
                                if (emailController.text == '') {
                                  emailCheck = 'error';
                                }
                                if (passwordController.text == '') {
                                  passwordCheck = 'error';
                                }

                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  setState(() {
                                    passwordEqual = true;
                                  });
                                } else {
                                  setState(() {
                                    passwordEqual = false;
                                  });
                                }
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) => {Get.offAllNamed('/')})
                                      // ignore: invalid_return_type_for_catch_error
                                      .catchError((e) => {
                                            Navigator.pop(context),
                                            setState(() {
                                              errorhandle = e.message;
                                            })
                                          });
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            color: purplePrimary,
                            textColor: whitePrimary,
                            fontsize: generalFontSize,
                            title: 'Create Account'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: generalFontSize,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return  LoginScreen();
                                      },
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                'login here',
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    decoration: TextDecoration.underline,
                                    color: purplePrimary,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
