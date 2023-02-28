import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';


class pagInicial extends StatefulWidget {
  const pagInicial({Key? key}) : super(key: key);

  @override
  State<pagInicial> createState() => _pagInicialState();
}

class _pagInicialState extends State<pagInicial> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movies = getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barraSuperior(),
      body: corpo(),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text('Filmes'),
    );
  }

  corpo() {
    return Scaffold(
      body: (listarMovies()),
    );
  }


  listarMovies() {
    return Card(
      margin: EdgeInsets.all(15),
      child: FutureBuilder<List<Movie>>(
        future: movies,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Movie movie = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(movie.title),
                  );
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }


  Future<List<Movie>> getMovies() async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/550?api_key=567a5917c8a4b919ea07dc7a89794c36');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List listMovies = json.decode(response.body);
      return listMovies.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Não foi possível carregador os links');
    }
  }
}