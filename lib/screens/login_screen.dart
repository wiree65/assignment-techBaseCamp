import 'package:bartering/config/string.dart';
import 'package:bartering/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/constants.dart';
import '../provider/authenticateProvider.dart';
import 'landing_screen.dart';

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
  String errorMessage = incorrectAuthException;
  bool isError = false;
  void login(BuildContext context) async {
    print(emailController.text + ' ' + passwordController.text);
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false).login(
          emailController.text.toString(), passwordController.text.toString());
      // ProfileScreen(email: emailController.text.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LandingScreen(sectionIndex: 0);
          },
        ),
      );
    } catch (error) {
      print(error);
      Navigator.pop(context);
      if (error.toString().contains('401')) {
        setState(() {
          isError = true;
        });
      }
      if (error.toString().contains('403')) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {

        //     },
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                          padding: const EdgeInsets.all(20),
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                  child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                )),
                              )),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 45),
                          width: width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '',
                                  style: TextStyle(
                                      // color: kPrimaryFont,
                                      fontSize: 24,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'login',
                                    style: TextStyle(
                                      // color: kPrimaryFont,
                                      fontSize: 14,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 14.5),
                                      child: Text(
                                        'new here?',
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
                                                  return RegisterScreen();
                                                },
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text(
                                          'create an account',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Quicksand',
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xFF6D65AD),
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ])),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          width: 325,
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
                                    fontFamily: 'Quicksand', fontSize: 15),
                                border: InputBorder.none),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          width: 325,
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
                                    fontFamily: 'Quicksand', fontSize: 15),
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
                      isError
                          ? Row(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12.0, left: 48),
                                child: Text(
                                  errorMessage,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Quicksand',
                                    color: Color.fromARGB(255, 197, 38, 38),
                                  ),
                                ),
                              ),
                            ])
                          : Container(),
                      Container(
                        width: width,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return
                                  //     },
                                  //   ),
                                  // );
                                });
                              },
                              child: const Text(
                                'Forget password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Quicksand',
                                  color: Color(0xFF707070),
                                ),
                              )),
                        ),
                      ),
                      Button(
                          color: purplePrimary,
                          textColor: whitePrimary,
                          fontsize: 16.00,
                          onPress: () {
                            setState(() {
                              isError = false;
                            });
                            Navigator.pop(context);
                            login(context);
                          },
                          title: 'Login'),
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
