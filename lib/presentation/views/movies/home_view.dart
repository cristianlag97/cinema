import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularsMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedmoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMoviesState = ref.watch(nowPlayingMoviesProvider);
    final popularMoviesState = ref.watch(popularsMoviesProvider);
    final sliderShowMovies = ref.watch(moviesSlideShowProvider);
    final topRatedMoviesState = ref.watch(topRatedmoviesProvider);
    final upcomingoviesState = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(slivers: <Widget>[
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: CustomAppBar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: <Widget>[
              // const CustomAppBar(),
              MoviesSliderShow(movies: sliderShowMovies),
              MovieHorizontalListView(
                movies: nowPlayingMoviesState,
                title: 'En cines',
                subTitle: 'Lunes 20',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                movies: upcomingoviesState,
                title: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                movies: popularMoviesState,
                title: 'Populares',
                loadNextPage: () =>
                    ref.read(popularsMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                movies: topRatedMoviesState,
                title: 'Mejor calificada',
                subTitle: 'General',
                loadNextPage: () =>
                    ref.read(topRatedmoviesProvider.notifier).loadNextPage(),
              ),
              const SizedBox(height: 50),
            ],
          );
        }, childCount: 1),
      ),
    ]);
  }
}