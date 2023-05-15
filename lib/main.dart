import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginScreen());
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (ctx) => AuthenticateProvider()),
    //   ],
    //   child: Consumer<AuthenticateProvider>(
    //     builder: (ctx, auth, child) => MaterialApp(
    //       title: 'Easy Bartering',
    //       debugShowCheckedModeBanner: false,
    //       home:
    //           // LandingScreen()

    //           auth.isAuth
    //               ? const LandingScreen(
    //                   sectionIndex: 0,
    //                 )
    //               : FutureBuilder(
    //                   future: auth.tryAutoLogin(),
    //                   builder: (ctx, authResultSnapshot) =>
    //                       authResultSnapshot.connectionState ==
    //                               ConnectionState.waiting
    //                           ? const SplashScreen()
    //                           : const LoginScreen(),
    //                 ),
    //     ),
    //   ),
    // );
  }
}
