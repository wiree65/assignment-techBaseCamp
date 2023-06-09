import 'package:flutter/material.dart';

import 'constants.dart';

class MoiveListScrollColumn extends StatelessWidget {
  final width;
  final list;

  // ignore: use_key_in_widget_constructors
  const MoiveListScrollColumn({
    this.width,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/unnamed.jpeg',
                    width: width * 0.35,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          width: width * 0.5,
                          child: Text(
                            "Transformers: Rise of the Beasts",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: generalFontSize),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade800,
                            size: 30.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              '10/10 IMDb',
                              style: TextStyle(
                                  fontSize: 15, color: blackPrimaryFont),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey.shade400,
                            size: 30.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              '2 h 34 m',
                              style: TextStyle(
                                  fontSize: 15, color: blackPrimaryFont),
                            ),
                          ),
                        ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(children: [
                          Text(
                            'Released since : 2014',
                            style: TextStyle(
                                fontSize: 15, color: blackPrimaryFont),
                          ),
                        ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 10),
                        child: Row(children: [
                          Text(
                            'Genre: Action, Drama',
                            style: TextStyle(
                                fontSize: 15, color: blackPrimaryFont),
                          ),
                        ]),
                      ),
                    ]),
              ]),
        ],
      ),
    );
  }
}
