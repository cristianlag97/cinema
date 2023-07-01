part of presentation.widget.shared;

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({required this.refresh, super.key});

  final VoidCallback refresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Icon(Icons.movie_outlined, color: colors.primary),
                const SizedBox(width: 5),
                Text('title'.tr(), style: titleStyle),
                const Spacer(),
                _SelectLangage(ref: ref, refresh: refresh),
                IconButton(
                  onPressed: () {
                    final searchedMovies = ref.read(searchMoviesProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchMovieDelegate(
                        initialMovies: searchedMovies,
                        searchMovies: ref
                            .read(searchMoviesProvider.notifier)
                            .searchMovieByQuery,
                      ),
                    ).then((movie) {
                      if (movie == null) return;
                      context.push('/home/0/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ));
  }
}

class _SelectLangage extends StatefulWidget {
  const _SelectLangage({required this.refresh, required this.ref});

  final WidgetRef ref;
  final VoidCallback refresh;

  @override
  State<_SelectLangage> createState() => _SelectLangageState();
}

class _SelectLangageState extends State<_SelectLangage> {
  @override
  Widget build(BuildContext context) {
    final prueba = widget.ref.watch(languageProvider);
    final listlanguage = widget.ref.watch(listLanguageProvider);

    return DropdownButton(
        underline: const SizedBox(),
        icon: SvgPicture.asset(
          prueba.flag,
          // ListLanguages.languages[1].flag,
          width: 20,
        ),
        items: listlanguage
            .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                  value: lang,
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(lang.flag, width: 25),
                      const SizedBox(width: 8),
                      Text(lang.country)
                    ],
                  ),
                ))
            .toList(),
        onChanged: (language) {
          widget.ref
              .read(languageProvider.notifier)
              .toggleLanguage(context, language!, widget.refresh);
        });
  }
}
