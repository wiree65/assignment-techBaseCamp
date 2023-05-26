import 'package:flutter/material.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/search_screen.dart';

import '../components/constants.dart';
import '../components/headerWithButton.dart';
import '../components/movieListScrollColumn.dart';
import '../components/movieListScrollRow.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();

  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user?.email.toString());
  }

  @override
  Widget build(BuildContext ctx) {
    double width = MediaQuery.of(context).size.width;

    List<String> genre = [
      "Action",
      "Crime",
      "Comedy",
    ];

    return Container(
        color: whitePrimary,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              color: whitePrimary,
              child: SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(top: generalPaddingLeftRight),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: generalPaddingLeftRight,
                                left: generalPaddingLeftRight,
                                right: generalPaddingLeftRight),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.grey.shade300,
                                        child: const Text(''),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: generalPaddingLeftRight),
                                        child: Text(
                                          "Hi " +
                                              user!.email
                                                  .toString()
                                                  .split('@')[0] +
                                              " !",
                                          style: TextStyle(
                                              fontSize: generalFontSize,
                                              fontWeight: FontWeight.bold,
                                              color: blackPrimaryFont),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.logout,
                                            size: 25, color: purplePrimary),
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return  LoginScreen();
                                          }));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      size: 30, color: purplePrimary),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SearchScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20),
                            child: HeaderWithButton(
                              headerTitle: 'In Theater',
                              buttonTitle: 'See more',
                            ),
                          ),
                          MoiveListScrollRow(width: width),
                          const HeaderWithButton(
                            headerTitle: 'Old Moive',
                            buttonTitle: 'See more',
                          ),
                          for (int i = 0; i < 10; i++)
                            MoiveListScrollColumn(width: width, list: genre),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
