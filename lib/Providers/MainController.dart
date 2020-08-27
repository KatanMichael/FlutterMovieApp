

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MainController extends ChangeNotifier {
  final String API_KEY = "e59a3745b3e4534b3d9d3541be46ad9e";
  List popularMovies = List();
  List genres = List();

  List getGenres()
  {
    return genres;
  }

  MainController()
  {
    updateListOfGenres();
  }

  void updateListOfGenres() async
  {
    String url = "https://api.themoviedb.org/3/genre/movie/list?api_key=$API_KEY&language=en-US";

    http.Response response = await http.get(url,

    headers: {"Accept": "application/json"}
    );

    var decode = json.decode(response.body);

    genres = decode["genres"];
    notifyListeners();
  }

  List getPoplarMovies()
  {
    if(popularMovies.length == 0)
      {
        initPopularMovies();
      }
    return popularMovies;
  }

  Future<List> initPopularMovies() async
  {
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=en-US&page=";

    if (popularMovies.length == 0) {
      http.Response response = await http
          .get(
          Uri.encodeFull(url + "1"), headers: {"Accept": "application/json"});

      var decode = json.decode(response.body);

      popularMovies = decode["results"];
    }
    return popularMovies;
    notifyListeners();
  }

  void getPopularMoviesByPage(int page) async
  {
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=en-US&page=";

    http.Response response = await http
        .get(
        Uri.encodeFull(url + page.toString()), headers: {"Accept": "application/json"});

    var decode = json.decode(response.body);

    popularMovies += decode["results"];
    notifyListeners();
  }
}