import 'package:flutter/material.dart';
import 'package:my_app/screens/landing_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'provider/movieProvider.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main(dynamic isTest) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    isTest: isTest,
  ));
}

class MyApp extends StatefulWidget {
  final bool isTest;
  const MyApp({Key? key, required this.isTest}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => MovieProvider()),
        ],
        child: Consumer<MovieProvider>(
          builder: (ctx, auth, child) => GetMaterialApp(
            theme: ThemeData(fontFamily: "Quicksand"),
            initialRoute: "/",
            getPages: [
              GetPage(
                  name: "/",
                  page: () => user != null
                      ? widget.isTest
                          ? const LoginScreen()
                          : const LandingScreen()
                      : const LoginScreen()),
              GetPage(name: '/register', page: () => const RegisterScreen()),
              GetPage(name: '/landing', page: () => const LandingScreen()),
              GetPage(name: '/search', page: () => const SearchScreen()),
            ],
            title: 'Movie',
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
