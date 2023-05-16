import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
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
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Let’s get start',
                              style: TextStyle(
                                  // color: kPrimaryFont,
                                  fontSize: 24,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Create an account to start watching movie',
                              style: TextStyle(
                                // color: kPrimaryFont,
                                fontSize: 14,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              width: width,
                              height: 55,
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
                                decoration: const InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Quicksand', fontSize: 15),
                                    border: InputBorder.none),
                              )),
                        ),
                        emailCheckError == 'error'
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 20, left: 25),
                                child: const Text(
                                  'โปรดใส่อีเมลบัญชีผู้ใช้',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              width: width,
                              height: 55,
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
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Quicksand', fontSize: 15),
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
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              width: width,
                              height: 55,
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
                                padding: const EdgeInsets.only(
                                    top: 10, left: 45, right: 45),
                                child: Text(
                                  errorhandle,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              )
                            : Container(),
                        emailCheck == 'error'
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 10, left: 45),
                                child: const Text(
                                  'please fill in email',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              )
                            : Container(),
                        passwordCheck == 'error'
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 10, left: 45),
                                child: const Text(
                                  'please fill in password',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              )
                            : Container(),
                        passwordEqual == false
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 10, left: 45),
                                child: const Text(
                                  'password does not match',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        Button(
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

                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) => {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const LoginScreen();
                                              },
                                            ),
                                          )
                                        })
                                    // ignore: invalid_return_type_for_catch_error
                                    .catchError((e) => {
                                          Navigator.pop(context),
                                          setState(() {
                                            errorhandle = e.message;
                                          })
                                        });
                              });
                            },
                            color: purplePrimary,
                            textColor: whitePrimary,
                            fontsize: 15.00,
                            title: 'Create Account'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                'Already have an account?',
                                style: TextStyle(
                                  // color: kPrimaryFont,
                                  fontSize: 14,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginScreen();
                                        },
                                      ),
                                    );
                                  });
                                },
                                child: const Text(
                                  'login here',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Quicksand',
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFF6D65AD),
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
