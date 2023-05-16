import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../provider/movieProvider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final ScrollController _scrollController = ScrollController();

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
                              child: Column(children: [
                                Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          size: 20,
                                          color: purplePrimary,
                                        ),
                                        onPressed: () {
                                          searchProvider.searchResults.clear();
                                          Navigator.pop(context);
                                        }),
                                    SizedBox(
                                      width: width * 0.83,
                                      child: TextField(
                                        controller: _searchController,
                                        onChanged: (query) {
                                          searchProvider
                                              .performSearch(query.trim());
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(14),
                                          fillColor: Colors.grey.shade300,
                                          hintText: "Search",
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey.shade500,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                Container(
                                  height: height,
                                  padding: const EdgeInsets.all(16),
                                  child: searchProvider.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : searchProvider.searchResults.isEmpty
                                          ? const Text('No results found.')
                                          : ListView.builder(
                                              itemCount: searchProvider
                                                  .searchResults.length,
                                              itemBuilder: (context, index) {
                                                final movie = searchProvider
                                                    .searchResults[index];
                                                return ListTile(
                                                  leading: movie.poster != 'N/A'
                                                      ? Container(
                                                          height: 160,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage(
                                                                  movie.poster),
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  title: Text(movie.title),
                                                  subtitle: Text(movie.year),
                                                );
                                              },
                                            ),
                                ),
                              ]),
                            )))))));
  }
}
