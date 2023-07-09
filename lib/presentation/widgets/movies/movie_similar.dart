part of presentation.widget.movies;

class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    return similarMoviesFuture.when(
      data: (movies) => _Recomendations(movies: movies),
      error: (_, __) => Center(
          child: Text('movie_info.empty_recomendation_description'.tr())),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MovieHorizontalListView(
          title: 'movie_info.recomendation_title'.tr(), movies: movies),
    );
  }
}
