import 'package:flutter/foundation.dart';

class PopularMovie {
  // {
  // "id": "tt1464335",
  // "rank": "1",
  // "rankUpDown": "+12",
  // "title": "Uncharted",
  // "fullTitle": "Uncharted (2022)",
  // "year": "2022",
  // "image": "https://m.media-amazon.com/images/M/MV5BOTNkN2ZmMzItOTAwMy00MmM5LTg5YTgtNmE5MThkMDE2ODJiXkEyXkFqcGdeQXVyMDA4NzMyOA@@._V1_SX300.jpg",
  // "crew": "Ruben Fleischer (dir.), Tom Holland, Mark Wahlberg",
  // "imDbRating": "6.7",
  // "imDbRatingCount": "30992"
  // },

  PopularMovie({
    required this.id,
    required this.rank,
    required this.rankUpDown,
    required this.title,
    required this.year,
    required this.image,
    required this.crew,
    required this.imdbRating,
    required this.imdbRatingCount
  });

  // PopularMovie.someNamedConstructor({
  //   required this.id,
  //   required this.rank,
  //   required this.rankUpDown,
  //   required this.title,
  //   required this.year,
  //   required this.image,
  //   required this.crew,
  //   required this.imdbRating,
  //   required this.imdbRatingCount
  // });

  factory PopularMovie.fromJson(Map<String, dynamic> json)
  {
    return PopularMovie(
        id: json["id"],
        rank: json["rank"],
        rankUpDown: json["rankUpDown"],
        title: json["title"],
        year: json["year"],
        image: json["image"],
        crew: json["crew"],
        imdbRating: json["imDbRating"],
        imdbRatingCount: json["imDbRatingCount"],
    );
  }

  final String id;
  final String rank;
  final String rankUpDown;
  final String title;
  final String year;
  final String image;
  final String crew;
  final String imdbRating;
  final String imdbRatingCount;
}