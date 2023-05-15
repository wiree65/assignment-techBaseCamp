import 'package:flutter/material.dart';

import '../components/buttonGenre.dart';
import '../components/constants.dart';

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
                                const Icon(
                                  Icons.search,
                                  color: purplePrimary,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'In Theater',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: blackPrimaryFont),
                                      )),
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'See more',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Quicksand',
                                            color: blackPrimaryFont),
                                      ),
                                      style: ButtonStyle(
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Row(
                            children: [
                              SizedBox(
                                height: 315.0,
                                width: width,
                                child: SizedBox(
                                    child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(15, (int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Image.asset(
                                                'assets/images/unnamed.jpeg',
                                                width: 150,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: SizedBox(
                                                width: 150,
                                                child: Text(
                                                  "Transformers: Rise of the Beasts",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow.shade800,
                                                  size: 30.0,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    '10/10 IMDb',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            BlackPrimaryFont),
                                                  ),
                                                ),
                                              ]),
                                            )
                                          ]),
                                    );
                                  }),
                                )),
                              )
                            ],
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Row(
                                children: [
                                  const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Movie',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: blackPrimaryFont),
                                      )),
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'See more',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Quicksand',
                                            color: blackPrimaryFont),
                                      ),
                                      style: ButtonStyle(
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          for (int i = 0; i < 10; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Image.asset(
                                            'assets/images/unnamed.jpeg',
                                            width: 150,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: SizedBox(
                                                  width: width * 0.5,
                                                  child: const Text(
                                                    "Transformers: Rise of the Beasts",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 10),
                                                child: Row(children: [
                                                  Icon(
                                                    Icons.star,
                                                    color:
                                                        Colors.yellow.shade800,
                                                    size: 30.0,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      '10/10 IMDb',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              BlackPrimaryFont),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 10),
                                                child: SizedBox(
                                                    width: width * 0.5,
                                                    child: Wrap(
                                                      spacing:
                                                          4.0, // gap between adjacent chips
                                                      runSpacing:
                                                          10.0, // gap between lines
                                                      children: [
                                                        for (int i = 0;
                                                            i < 3;
                                                            i++)
                                                          ButtonGenre(
                                                            title: genre[i],
                                                          )
                                                      ],
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(children: [
                                                  Icon(
                                                    Icons.access_time_outlined,
                                                    color: Colors.grey.shade400,
                                                    size: 30.0,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      '2 h 34 m',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              BlackPrimaryFont),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ]),
                                      ]),
                                ],
                              ),
                            )
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
