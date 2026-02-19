import 'package:d_movie_app/pages/dashboard_page.dart';
import 'package:d_movie_app/pages/json_movie_page.dart';
import 'package:d_movie_app/pages/login_page.dart';
import 'package:d_movie_app/pages/top_rated_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future(() async {
      final prefs = await SharedPreferences.getInstance();
      final isAuthenticated = prefs.getBool("IS_AUTHENTICATED");

      if (!mounted) return;
      if (isAuthenticated ?? false)
      {
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
          return DashboardPage();
        }));
      }
      else
      {
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
          return LoginPage();
        }));
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Movie App",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
