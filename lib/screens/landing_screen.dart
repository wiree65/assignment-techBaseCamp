import 'package:flutter/material.dart';
import 'package:my_app/screens/search_screen.dart';

import '../components/constants.dart';
import '../components/headerWithButton.dart';
import '../components/movieListScrollColumn.dart';
import '../components/movieListScrollRow.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    double width = MediaQuery.of(context).size.width;

    List<String> genre = [
      "Action",
      "Crime",
      "Comedy",
      "Drama",
      "Honor",
      "Thriller",
      "Romance",
      "Western"
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
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 20, right: 20),
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
                                      const Padding(
                                        padding: EdgeInsets.only(left: 13.0),
                                        child: Text(
                                          'Hi Wirawat',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: blackPrimaryFont),
                                        ),
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
                            headerTitle: 'Moive',
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
