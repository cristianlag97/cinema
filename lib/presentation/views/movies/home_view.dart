part of presentation.views.movies;

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);

    final lagunage = ref.watch(languageProvider);
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    DateTime now = DateTime.now();
    String dayOfWeek =
        DateFormat('EEEE d', lagunage.locale!.language).format(now);

    FlutterNativeSplash.remove();

    final nowPlayingMoviesState = ref.watch(nowPlayingMoviesProvider);
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
                title: 'home.in_theaters'.tr(),
                subTitle: dayOfWeek,
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                movies: upcomingoviesState,
                title: 'home.soon'.tr(),
                subTitle: 'home.in_this_month'.tr(),
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                movies: topRatedMoviesState,
                title: 'home.top_rated'.tr(),
                subTitle: 'home.general'.tr(),
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

  @override
  bool get wantKeepAlive => true;
}
