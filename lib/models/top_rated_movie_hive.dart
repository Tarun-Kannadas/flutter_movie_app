import 'package:hive/hive.dart';

part 'top_rated_movie_hive.g.dart';

@HiveType(typeId: 0, adapterName: 'TopRatedMovieHiveAdapter')
class TopRatedMovieHive extends HiveObject {
  TopRatedMovieHive({
    required this.title,
    required this.year,
    required this.image,
    required this.imdbRating,
  }); // 2. Added the missing semicolon

  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? year;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String? imdbRating;
}