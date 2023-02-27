import 'package:flutter/material.dart';

// Model
import '../../models/movie_model.dart';

// Controller
import '../../controllers/movie_controller.dart';

// Components
import '../components/loading.dart';
import '../components/list.dart';
import '../components/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movie> _movies = <Movie>[];
  List<Movie> _moviesDisplay = <Movie>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies().then((value) {
      setState(() {
        _isLoading = false;
        _movies.addAll(value);
        _moviesDisplay = _movies;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (!_isLoading) {
              return index == 0
                  ? MySearch(
                      hintText: 'ex: name, nickname or portrayed.',
                      onChanged: (searchText) {
                        searchText = searchText.toLowerCase();
                        setState(() {
                          _moviesDisplay = _movies.where((u) {
                            var titleLowerCase = u.title.toLowerCase();
                            return titleLowerCase.contains(searchText);
                          }).toList();
                        });
                      },
                    )
                  : MyList(movie: _moviesDisplay[index - 1]);
            } else {
              return const MyLoading();
            }
          },
          itemCount: _moviesDisplay.length + 1,
        ),
      ),
    );
  }
}