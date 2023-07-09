part of presentation.views.movies;

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  ConsumerState<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final popularMovies = ref.watch(popularsMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      body: MovieMasonry(
          loadNextPage: () =>
              ref.read(popularsMoviesProvider.notifier).loadNextPage(),
          movies: popularMovies),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
