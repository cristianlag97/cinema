import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovienotifier extends StateNotifier<List<Movie>> {
  SearchMovienotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  final SearchMovieCallback searchMovies;
  final Ref ref;

  Future<List<Movie>> searchMovieByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}

final searchMoviesProvider =
    StateNotifierProvider<SearchMovienotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchMovienotifier(
    searchMovies: movieRepository.searchMovie,
    ref: ref,
  );
});
