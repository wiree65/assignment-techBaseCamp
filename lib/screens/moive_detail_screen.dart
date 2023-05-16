import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';
import '../provider/movieProvider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbID;

  const MovieDetailScreen({Key? key, required this.imdbID}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  dynamic detail;

  List<String> topic = [
    "Title",
    "Year",
    "Rated",
    "Released",
    "Runtime",
    "Genre",
    "Director",
    "Writer",
    "Actors",
    "Plot",
    "Language",
    "Country",
    "Awards",
    "Poster",
    "Metascore",
    "ImdbRating",
    "ImdbVotes",
    "ImdbID",
    "Type",
    "Dvd",
    "BoxOffice",
    "Production",
    "Website",
  ];
  Future<void> fetchRequestIdDetail(String id) async {
    try {
      detail = await Provider.of<MovieProvider>(context, listen: false)
          .fetchCategory(id);
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.response);
    }
  }

  @override
  void initState() {
    fetchRequestIdDetail(widget.imdbID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;

    return Container(
        color: whitePrimary,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined,
                        color: purplePrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: const Text(
                    "Moive Detail",
                    style: TextStyle(color: blackPrimaryFont),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                    color: whitePrimary,
                    child: SafeArea(
                        child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(children: [
                                FutureBuilder(
                                    future: fetchRequestIdDetail(widget.imdbID),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (detail == null) {
                                        return const Center(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 16.0),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          purplePrimary))),
                                        ));
                                      } else {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, right: 20),
                                              child: Center(
                                                  child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                child: Image.network(
                                                  detail.data['Poster'] ??
                                                      'N/A',
                                                  fit: BoxFit.fill,
                                                  width: width,
                                                ),
                                              )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Table(
                                                columnWidths: const {
                                                  0: FractionColumnWidth(0.25),
                                                  1: FractionColumnWidth(0.75),
                                                },
                                                border: TableBorder.all(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                    width: 1.0,
                                                    color:
                                                        Colors.grey.shade400),
                                                children: [
                                                  for (int i = 0;
                                                      i < topic.length;
                                                      i++)
                                                    TableRow(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(topic[i]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(detail.data[
                                                                topic[i]] ??
                                                            'N/A'),
                                                      ),
                                                    ]),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }),
                              ]),
                            )))))));
  }
}
