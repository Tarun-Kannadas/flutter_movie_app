import 'package:d_movie_app/models/top_rated_movie.dart';

sealed class TopRatedMoviesUiState {}

class TopRatedMoviesUiStateInitial extends TopRatedMoviesUiState {}

class TopRatedMoviesUiStateLoading extends TopRatedMoviesUiState {}

class TopRatedMoviesUiStateSuccess extends TopRatedMoviesUiState {

  TopRatedMoviesUiStateSuccess(this.movieList);

  final List<TopRatedMovie> movieList;
}

class TopRatedMoviesUiStateFailure extends TopRatedMoviesUiState {}