import 'package:flutter/material.dart';

import '../components/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        color: whitePrimary,
        child: SafeArea(
            child: Scaffold(
                body: Container(
                    color: whitePrimary,
                    child: SafeArea(
                        child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 20,
                                    color: purplePrimary,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              SizedBox(
                                width: width * 0.83,
                                child: TextField(
                                  onChanged: (value) {
                                    _runFilter(value);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(14),
                                    fillColor: Colors.grey.shade300,
                                    hintText: "Search",
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey.shade500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ))))));
  }
}
