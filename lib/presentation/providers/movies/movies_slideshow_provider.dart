part of presentation.provider.actors;

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final moviesStateProvider = ref.watch(nowPlayingMoviesProvider);
  if (moviesStateProvider.isEmpty) return [];

  return moviesStateProvider.sublist(0, 6);
});
