import 'dart:convert';
import 'dart:math';

import 'package:d_movie_app/cubits/top_rated_movies_ui_state.dart';
import 'package:d_movie_app/models/top_rated_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class TopRatedMovieCubit extends Cubit<TopRatedMoviesUiState> {
  TopRatedMovieCubit() : super(TopRatedMoviesUiStateInitial());

  void fetchTopRatedMovies() async {
    emit(TopRatedMoviesUiStateLoading());

    try
    {
      final List<TopRatedMovie> movieList = await _getTopRatedMovies();

      emit(TopRatedMoviesUiStateSuccess(movieList));
    }
    catch (e)
    {
      emit(TopRatedMoviesUiStateFailure());
    }
  }

  Future<List<TopRatedMovie>> _getTopRatedMovies() async {
    final topRatedMovieUrl = Uri.parse("https://movie-api-rish.onrender.com/top-rated");
    final response = await http.get(topRatedMovieUrl);

    final responseJson = jsonDecode(response.body);

    return (responseJson['items'] as List<dynamic>)
      .map((movieJson) => TopRatedMovie.fromJson(movieJson))
      .toList();
  }
}