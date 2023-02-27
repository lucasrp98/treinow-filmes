import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

const String url = "https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY";

List<Movie> parseMovie(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var characters = list.map((e) => Movie.fromJson(e)).toList();
  return characters;
}

Future<List<Movie>> fetchMovies() async {
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List listMovies = json.decode(response.body);
    return listMovies.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}