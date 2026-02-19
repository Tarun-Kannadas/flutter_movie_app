import 'package:d_movie_app/pages/favourite_movies_page.dart';
import 'package:d_movie_app/pages/json_movie_page.dart';
import 'package:d_movie_app/pages/top_rated_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _currentIndex = 0;

  final _pages = <Widget>[
    const TopRatedMoviesPage(),
    const JsonMoviePage(),
    const FavouriteMoviesPage(),
  ];

  final _items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Icon(Icons.movie),
        label: 'Top Rated'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Popular'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favourite'
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Movie Database"),
          actions: [
            IconButton(
                onPressed: (){
                  _logout();
                },
                icon: const Icon(Icons.logout)
            )
          ]
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _logout() async{
    final pref = await SharedPreferences.getInstance();
    final isDeleted = await pref.setBool("IS_AUTHENTICATED", false);

    if (isDeleted) {
      if (mounted)
      {
        Navigator.pushReplacement((context), MaterialPageRoute(builder: (context){
          return const LoginPage();
        }));
      }
    }
  }
}
