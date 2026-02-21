import 'package:d_movie_app/models/top_rated_movie_hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouriteMoviesPage extends StatefulWidget {
  const FavouriteMoviesPage({super.key});

  @override
  State<FavouriteMoviesPage> createState() => _FavouriteMoviesPageState();
}

class _FavouriteMoviesPageState extends State<FavouriteMoviesPage> {
  late Box<TopRatedMovieHive> _movieBox;
  late List<TopRatedMovieHive> _movieHiveList;

  @override
  void initState() {
    super.initState();

    _movieBox = Hive.box("top-rated-movies");
    _movieHiveList = _movieBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Favourite Movies'),
      //   actions: [
      //     // Add a delete button to the top right corner
      //     IconButton(
      //       icon: const Icon(Icons.delete_sweep),
      //       tooltip: 'Clear All Favourites',
      //       onPressed: () async {
      //         // 1. Clear the box
      //         await _movieBox.clear();
      //
      //         // 2. Show a quick confirmation toast
      //         if (context.mounted) {
      //           ScaffoldMessenger.of(context).clearSnackBars();
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(content: Text('All favourites cleared!')),
      //           );
      //         }
      //       },
      //     ),
      //   ],
      // ),
      body: ValueListenableBuilder(
        valueListenable: _movieBox.listenable(),
        builder: (context, Box<TopRatedMovieHive> box, _) {
          final movieHiveList = box.values.toList();

          if (movieHiveList.isEmpty) {
            return const Center(child: Text("No favourite movies yet!"));
          }

          return ListView.builder(
            itemCount: movieHiveList.length,
            itemBuilder: (ctx, index) {
              final movie = _movieHiveList[index];
              return ListTile(
                leading: Image.network(
                  movie.image ?? "Unavailable",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.black12,
                    );
                  },
                ),
                title: Text(movie.title ?? 'Unavailable'),
                subtitle: Text(movie.year ?? "Unavailable"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(movie.imdbRating ?? "Unavailable"),
                    IconButton(
                      onPressed: () {
                        _deleteMovie(movie);
                      },
                      icon: Icon(Icons.delete_outline),
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _deleteMovie(TopRatedMovieHive movie) {
    setState(() {
      movie.delete();
      _movieHiveList = _movieBox.values.toList();
    });
  }
}
