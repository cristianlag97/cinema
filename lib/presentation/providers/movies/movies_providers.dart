part of presentation.provider.actors;

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback? fetchMoreMovies;

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    state.isEmpty && currentPage > 0 ? currentPage = 1 : currentPage++;

    // currentPage++;
    final List<Movie> movies = await fetchMoreMovies!(
      page: currentPage,
    );
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> refreshMovies() async {
    if (isLoading) return;
    isLoading = true;

    state = [];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

final StateNotifierProvider<MoviesNotifier, List<Movie>>
    nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final StateNotifierProvider<MoviesNotifier, List<Movie>>
    popularsMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopulars;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final StateNotifierProvider<MoviesNotifier, List<Movie>>
    topRatedmoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final StateNotifierProvider<MoviesNotifier, List<Movie>>
    upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});
