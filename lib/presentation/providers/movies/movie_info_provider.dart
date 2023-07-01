part of presentation.provider.actors;

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  MovieMapNotifier({required this.getMovie}) : super({});

  final GetMovieCallback getMovie;

  Future<void> loadmovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}

final StateNotifierProvider<MovieMapNotifier, Map<String, Movie>> movieInfo =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>(
  (ref) {
    final fetchMovie = ref.watch(movieRepositoryProvider).getMovieById;
    return MovieMapNotifier(getMovie: fetchMovie);
  },
);
