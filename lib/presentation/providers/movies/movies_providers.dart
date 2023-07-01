part of presentation.provider.actors;

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;
  // LanguageModel languageModel;

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(
      page: currentPage,
      // language:
      //     '${languageModel.locale.languageCode}-${languageModel.locale.countryCode}',
    );
    state = [...state, ...movies];

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
  // final fetchLanguage = ref.watch(languageProvider);
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final StateNotifierProvider<MoviesNotifier, List<Movie>>
    upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});
