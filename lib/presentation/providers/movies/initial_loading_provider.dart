part of presentation.provider.actors;

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularsMoviesProvider).isEmpty;
  final step3 = ref.watch(moviesSlideShowProvider).isEmpty;
  final step4 = ref.watch(topRatedmoviesProvider).isEmpty;
  final step5 = ref.watch(upcomingMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4 || step5) return true;

  return false;
});
