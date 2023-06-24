import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.pageIndex, super.key});

  final int pageIndex;

  static const name = 'home-movies';

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          //TODO: sirve para preservar el estado
          index: pageIndex,
          children: viewRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
      );
}
