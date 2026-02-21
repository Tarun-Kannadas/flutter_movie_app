import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../cubits/top_rated_movie_cubit.dart';
import '../cubits/top_rated_movies_ui_state.dart';
import '../models/top_rated_movie_hive.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  late Box<TopRatedMovieHive> _movieBox;
  late List<TopRatedMovieHive> _favoriteMovieList;

  @override
  void initState() {
    super.initState();

    context.read<TopRatedMovieCubit>().fetchTopRatedMovies();

    _movieBox = Hive.box<TopRatedMovieHive>('top-rated-movies');
    _favoriteMovieList = _movieBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TopRatedMovieCubit, TopRatedMoviesUiState>(
        builder: (ctx, state) {
          return switch (state) {
            TopRatedMoviesUiStateLoading() => const Center(
              child: CircularProgressIndicator(),
            ),

            TopRatedMoviesUiStateSuccess() => ListView.builder(
              itemCount: state.movieList.length,
              itemBuilder: (ctx, index) {
                final movie = state.movieList[index];

                final matchedMovie = _favoriteMovieList
                    .cast<TopRatedMovieHive?>()
                    .firstWhere(
                      (favoriteMovie) => favoriteMovie?.title == movie.title,
                      orElse: () => null,
                    );

                final bool isFavorite = matchedMovie != null;

                void toggleFavoriteStatus() {
                  final movieHive = TopRatedMovieHive(
                    title: movie.title,
                    year: movie.year,
                    imdbRating: movie.imdbRating,
                    image: movie.image,
                  );

                  if (isFavorite) {
                    _deleteMovieHive(movieHive);
                  } else {
                    _saveMovieHive(movieHive);
                  }
                }

                return ListTile(
                  leading: Image.network(
                    movie.image,
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
                  title: Text(movie.title),
                  subtitle: Text(movie.year),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(
                        "${movie.imdbRating}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        onPressed: toggleFavoriteStatus,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            TopRatedMoviesUiStateFailure() => const Text('Failure'),
            _ => const CircularProgressIndicator(),
          };
        },
      ),
    );
  }

  void _saveMovieHive(TopRatedMovieHive movieHive) {
    _movieBox.put(movieHive.title, movieHive);

    setState(() {
      _favoriteMovieList = _movieBox.values.toList();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${movieHive.title} added!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _deleteMovieHive(TopRatedMovieHive movieHive) {
    _movieBox.delete(movieHive.title);

    setState(() {
      _favoriteMovieList = _movieBox.values.toList();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${movieHive.title} removed!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}
