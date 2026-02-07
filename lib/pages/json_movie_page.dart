import 'dart:convert';

import 'package:d_movie_app/models/popular_movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonMoviePage extends StatefulWidget {
  const JsonMoviePage({super.key, required String title});

  @override
  State<JsonMoviePage> createState() => _JsonMoviePageState();
}

class _JsonMoviePageState extends State<JsonMoviePage> {
  List<PopularMovie> _popularMoviesList = [];

  @override
  void initState() {
    super.initState();

    _fetchMovieFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: ListView.builder(
          itemCount: _popularMoviesList.length,
          itemBuilder: (context, index){
        return ListTile(
          leading: Image.network(
            _popularMoviesList[index].image,
            fit: BoxFit.cover,
            height: 50,
            width: 50,
            errorBuilder: (_,_,_) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              );
            },
          ),
          title: Text(_popularMoviesList[index].title),
          subtitle: Text(_popularMoviesList[index].year),
          trailing: Text(_popularMoviesList[index].imdbRating),
        );
      }),
    );
  }
  void _fetchMovieFromJson() async{
    final jsonString = await rootBundle.loadString("assets/popular_movies.json");
    final jsonMap = jsonDecode(jsonString);
    final moviesMap = jsonMap["items"] as List<dynamic>;
    _popularMoviesList = moviesMap.map((movieJson) => PopularMovie.fromJson(movieJson)).toList();
    setState(() {});
  }
}
