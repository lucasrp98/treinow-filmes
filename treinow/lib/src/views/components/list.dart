import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/movie_model.dart';
import '../pages/movie_details_page.dart';

class MyList extends StatelessWidget {
  final Movie movie;

  const MyList({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: movie.mov_id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(movie.img),
              ),
            ),
            title: Text(movie.title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailsPage(movie: movie)));
            },
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
