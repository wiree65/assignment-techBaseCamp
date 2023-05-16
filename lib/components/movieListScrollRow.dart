import 'package:flutter/material.dart';

import 'constants.dart';

class MoiveListScrollRow extends StatelessWidget {
  final width;

  // ignore: use_key_in_widget_constructors
  const MoiveListScrollRow({
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 315.0,
          width: width,
          child: SizedBox(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(15, (int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'assets/images/unnamed.jpeg',
                          width: 150,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            "Transformers: Rise of the Beasts",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
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
                      )
                    ]),
              );
            }),
          )),
        )
      ],
    );
  }
}
