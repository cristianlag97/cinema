part of presentation.views.movies;

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoadingPage = false;

  void loadNextPage() async {
    if (isLoadingPage || isLastPage) return;
    isLoadingPage = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoadingPage = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies =
        ref.watch(favoriteMoviesProvider).values.toList();
    ref.watch(languageProvider);

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text(
              'favorete_page.empty_state.title'.tr(),
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            Text(
              'favorete_page.empty_state.description'.tr(),
              style: const TextStyle(fontSize: 20, color: Colors.black45),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: Text(
                'favorete_page.empty_state.action'.tr(),
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      body: MovieMasonry(
        movies: movies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
