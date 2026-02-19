// "id": "tt0111161",
// "rank": "1",
// "title": "The Shawshank Redemption",
// "fullTitle": "The Shawshank Redemption (1994)",
// "year": "1994",
// "image": "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
// "crew": "Frank Darabont (dir.), Tim Robbins, Morgan Freeman",
// "imDbRating": "9.2",
// "imDbRatingCount": "2550040"

class TopRatedMovie {

  TopRatedMovie({
    this.rank = "Unavailable",
    this.title = "Unavailable",
    this.year = "Unavailable",
    this.image = "default",
    this.imdbRating = "0.0"
  });

  factory TopRatedMovie.fromJson(Map<String, dynamic> json)
  {
    return TopRatedMovie(
      rank: json['rank'],
      title: json['title'],
      year: json['year'],
      image: json['image'],
      imdbRating: json['imDbRating']
    );
  }

  final String rank;
  final String title;
  final String year;
  final String image;
  final String imdbRating;
}