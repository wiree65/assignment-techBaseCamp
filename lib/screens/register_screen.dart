import 'package:bartering/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/constants.dart';
import '../provider/authenticateProvider.dart';

class RegisterScreen extends StatefulWidget {
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
  @override
  var emailCheck = '';
  var passwordCheck = '';
  var confirmPasswordCheck = '';
  var firstnameCheck = '';
  var lastnameCheck = '';
  var emailCheckUsed = '';

  bool passwordEqual = true;

  var emailCheckError = '';
  var passwordCheckError = '';
  var confirmPasswordCheckError = '';
  var firstnameCheckError = '';
  var lastnameCheckError = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstnameController = TextEditingController();

  final TextEditingController lastnameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void register() async {
    try {
      showAlertDialog(context);
      await Provider.of<AuthenticateProvider>(context, listen: false).register(
        emailController.text,
        passwordController.text,
      );
      // Navigator.pop(context);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return
      //     },
      //   ),
      // );
    } catch (error) {
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
                          padding: const EdgeInsets.only(left: 48.0),
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
                          padding: const EdgeInsets.only(left: 48.0, top: 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              '',
                              style: TextStyle(
                                // color: kPrimaryFont,
                                fontSize: 14,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            width: 325,
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
                        emailCheckUsed != ''
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 20, left: 25),
                                child: const Text(
                                  'บัญชีนี้มีผู้ใช้แล้ว',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              )
                            : Container(),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            width: 325,
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
                        passwordCheckError == 'error'
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 20, left: 25),
                                child: const Text(
                                  'โปรดกรอกรหัสผ่าน',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              )
                            : Container(),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            width: 325,
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
                                        _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none),
                            )),
                        confirmPasswordCheckError == 'error'
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 20, left: 25),
                                child: const Text(
                                  'โปรดกรอกรหัสผ่านอีกครั้งเพื่อยืนยัน',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              )
                            : Container(),
                        passwordEqual == false
                            ? Container(
                                width: width,
                                padding:
                                    const EdgeInsets.only(top: 20, left: 25),
                                child: const Text(
                                  'รหัสผ่านไม่ตรงกัน',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 23,
                        ),
                        Button(
                            onPress: () {
                              setState(() {
                                register();
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 14.5),
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
