import 'package:bartering/provider/authenticateProvider.dart';
import 'package:bartering/screens/landing_screen.dart';
import 'package:bartering/screens/login_screen.dart';
import 'package:bartering/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthenticateProvider()),
      ],
      child: Consumer<AuthenticateProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'Moive Assignment',
          debugShowCheckedModeBanner: false,
          home:
              // LandingScreen()

              auth.isAuth
                  ? const LandingScreen(
                      sectionIndex: 0,
                    )
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const SplashScreen()
                              : const LoginScreen(),
                    ),
        ),
      ),
    );
  }
}
