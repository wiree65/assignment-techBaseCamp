import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/movieProvider.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // const MaterialApp(
        //     debugShowCheckedModeBanner: false, home: LoginScreen());
        MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MovieProvider()),
      ],
      child: Consumer<MovieProvider>(
        builder: (ctx, auth, child) => const MaterialApp(
            title: 'Movie',
            debugShowCheckedModeBanner: false,
            home: LoginScreen()

            // auth.isAuth
            //     ? const LandingScreen(
            //         sectionIndex: 0,
            //       )
            //     : FutureBuilder(
            //         future: auth.tryAutoLogin(),
            //         builder: (ctx, authResultSnapshot) =>
            //             authResultSnapshot.connectionState ==
            //                     ConnectionState.waiting
            //                 ? const SplashScreen()
            //                 : const LoginScreen(),
            ),
      ),
    );
  }
}
