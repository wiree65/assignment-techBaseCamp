import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/constants.dart';
import '../components/utils.dart';
import 'landing_screen.dart';
import 'register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    double height = MediaQuery.of(context).size.height;
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          width: width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Movie Assignment',
                                  style: TextStyle(
                                      // color: kPrimaryFont,
                                      fontSize: 25,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    'login with email to start watching movie',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'new here?',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Quicksand',
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const RegisterScreen();
                                                  },
                                                ),
                                              );
                                            });
                                          },
                                          child: const Text(
                                            'create an account',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Quicksand',
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color(0xFF6D65AD),
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ),
                              ])),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            width: width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: greyPrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Quicksand', fontSize: 16),
                                  border: InputBorder.none),
                            )),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          width: width,
                          height: 55,
                          decoration: BoxDecoration(
                            color: greyPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    fontFamily: 'Quicksand', fontSize: 16),
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
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Text(
                                errorhandle,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.red),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Button(
                            width: width,
                            color: purplePrimary,
                            textColor: whitePrimary,
                            fontsize: 16.00,
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
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LandingScreen();
                                      },
                                    ),
                                  );
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
                      const SizedBox(
                        height: 23,
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
