import 'package:cinemapedia/config/contans/enviroment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-movies';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(Enviroment.theMovieDbKey),
        ),
      );
}
