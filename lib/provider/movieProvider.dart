import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'model.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _searchResults = [];
  List<Movie> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://www.omdbapi.com/?apikey=1abc9ab2'));

  Future<void> performSearch(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('', queryParameters: {'s': query});
      if (response.statusCode == 200) {
        final data = response.data;

        if (data['Response'] == "True") {
          final searchResults =
              List<Movie>.from(data['Search'].map((result) => Movie(
                    title: result['Title'],
                    imdbID: result['imdbID'],
                    year: result['Year'],
                    poster: result['Poster'],
                  )));
          _searchResults = searchResults;
        } else {
          _searchResults = [];
        }
      } else {
        _searchResults = [];
      }
    } catch (error) {
      _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<dynamic> fetchDetail(String imdbID) async {
    dynamic response;
    try {
      response =
          await _dio.get('', queryParameters: {'i': imdbID, 'plot': 'full'});
    } catch (error) {}
    return response;
  }
}
