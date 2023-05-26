import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/constants.dart';
import '../components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: whitePrimary,
      child: SafeArea(
        child: Scaffold(
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
                              left: generalPaddingLeftRight,
                              right: generalPaddingLeftRight),
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
                                  padding: EdgeInsets.only(
                                      top: generalPaddingLeftRight),
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
                              top: generalPaddingTop,
                              left: generalPaddingLeftRight,
                              right: generalPaddingLeftRight),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: width,
                          height: generalHightButton,
                          decoration: BoxDecoration(
                            color: greyPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Obx(() => TextField(
                                controller: passwordController,
                                obscureText:
                                    !loginController.passwordVisible.value,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                        TextStyle(fontSize: generalFontSize),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        loginController.passwordVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        loginController.handlePassword();
                                      },
                                    ),
                                    border: InputBorder.none),
                              ))),
                      loginController.error.value != ''
                          ? Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  top: generalPaddingLeftRight,
                                  left: generalPaddingLeftRight,
                                  right: generalPaddingLeftRight),
                              child: Text(
                                loginController.error.value,
                                style: TextStyle(
                                    fontSize: generalFontSize,
                                    color: Colors.red),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.all(generalPaddingLeftRight),
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
                                loginController.handdleError(e.message!);
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
