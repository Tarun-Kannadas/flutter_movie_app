import 'package:d_movie_app/cubits/top_rated_movie_cubit.dart';
import 'package:d_movie_app/models/top_rated_movie_hive.dart';
import 'package:d_movie_app/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TopRatedMovieHiveAdapter());
  await Hive.openBox<TopRatedMovieHive>("top-rated-movies");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Ensure 'providers' is defined somewhere accessible!
      providers: [
        BlocProvider(create: (_) => TopRatedMovieCubit()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}