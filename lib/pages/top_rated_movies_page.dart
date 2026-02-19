import 'package:d_movie_app/cubits/top_rated_movie_cubit.dart';
import 'package:d_movie_app/cubits/top_rated_movies_ui_state.dart';
import 'package:d_movie_app/models/top_rated_movie_hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage ({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  late Box _movieBox;

  @override
  void initState()
  {
    super.initState();

    context.read<TopRatedMovieCubit>().fetchTopRatedMovies();

    _movieBox = Hive.box<TopRatedMovieHive>("top-rated-movies");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TopRatedMovieCubit, TopRatedMoviesUiState>(
        builder: (ctx, state) {
          return switch (state) {
            TopRatedMoviesUiStateLoading() => const Center(child: CircularProgressIndicator()),

            TopRatedMoviesUiStateSuccess(movieList: var movies) => ListView.builder(
              itemCount: movies.length,
              itemBuilder: (ctx, index) {
                final movie = movies[index];
                final String key = movie.title; // Our unique identifier

                // 1. Wrap the tile in a ValueListenableBuilder
                return ValueListenableBuilder(
                  valueListenable: _movieBox.listenable(), // 2. Listen to changes in the box
                  builder: (context, Box box, _) {

                    // 3. Check if THIS specific movie is in the database
                    final isFavorite = box.containsKey(key);

                    return ListTile(
                      // The background color will be our only visual indicator now
                      tileColor: isFavorite ? Colors.deepPurple.withOpacity(0.15) : null,
                      title: Text(movie.title),
                      subtitle: Text("Year: ${movie.year}"),

                      // Put the rating back in the trailing position!
                      trailing: Text(
                        "⭐ ${movie.imdbRating}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          movie.image,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          errorBuilder: (_, __, ___) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.movie),
                          ),
                        ),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).clearSnackBars();

                        if (isFavorite) {
                          box.delete(key);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${movie.title} removed!'), duration: const Duration(seconds: 1)),
                          );
                        } else {
                          final movieHive = TopRatedMovieHive(
                            title: movie.title,
                            year: movie.year,
                            image: movie.image,
                            imdbRating: movie.imdbRating,
                          );
                          box.put(key, movieHive);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${movie.title} favorited!'), duration: const Duration(seconds: 1)),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),

            TopRatedMoviesUiStateFailure() => const Center(child: Text('Failed to load movies')),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
