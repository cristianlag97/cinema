part of presentation.views.movies;

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularsMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedmoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    WidgetsBinding.instance.addObserver(this);
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    final lagunage = ref.watch(languageProvider);

    DateTime now = DateTime.now();
    String dayOfWeek =
        DateFormat('EEEE d', lagunage.locale.languageCode).format(now);

    final nowPlayingMoviesState = ref.watch(nowPlayingMoviesProvider);
    // final popularMoviesState = ref.watch(popularsMoviesProvider);
    final sliderShowMovies = ref.watch(moviesSlideShowProvider);
    final topRatedMoviesState = ref.watch(topRatedmoviesProvider);
    final upcomingoviesState = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: CustomAppBar(refresh: refresh),
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
                title: LocaleKeys.home_soon.tr(),
                subTitle: LocaleKeys.home_in_this_month.tr(),
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              // MovieHorizontalListView(
              //   movies: popularMoviesState,
              //   title: 'Populares',
              //   loadNextPage: () =>
              //       ref.read(popularsMoviesProvider.notifier).loadNextPage(),
              // ),
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
