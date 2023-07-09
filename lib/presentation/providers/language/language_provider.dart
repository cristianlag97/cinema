part of presentation.provider.language;

typedef ChangeLanguageCallback = Future<Language> Function(
    BuildContext context, Language language);

class LanguageNotifier extends StateNotifier<LanguageModel> {
  LanguageNotifier(this.ref, {required this.callback}) : super(LanguageModel());

  final ChangeLanguageCallback callback;
  final StateNotifierProviderRef<LanguageNotifier, LanguageModel> ref;

  Future<void> initStateLanguage() async {
    final int index = StorageService.instance.getLanguageCode;
    final String flag = StorageService.instance.getFlag;

    state = state.copyWith(
      flag: state.copyWith().flag ?? flag,
      locale: state.copyWith().locale ?? ListLanguages.languages[index],
    );
  }

  void toggleLanguage(BuildContext context, Language language) async {
    final languageSelected = await callback(context, language);
    state = state.copyWith(
      flag: languageSelected.flag,
      locale: languageSelected,
    );
    await cleanMovies();
    savedNewLocalStorage(language);
    await reloadMovies();
    ref.read(initialLoadingProvider);
  }

  Future<void> cleanMovies() async {
    await ref.read(nowPlayingMoviesProvider.notifier).refreshMovies();
    await ref.read(popularsMoviesProvider.notifier).refreshMovies();
    await ref.read(topRatedmoviesProvider.notifier).refreshMovies();
    await ref.read(upcomingMoviesProvider.notifier).refreshMovies();
    await ref.read(movieInfo.notifier).refreshListMovie();
  }

  Future<void> reloadMovies() async {
    await ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    await ref.read(popularsMoviesProvider.notifier).loadNextPage();
    await ref.read(topRatedmoviesProvider.notifier).loadNextPage();
    await ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  void savedNewLocalStorage(Language language) async {
    await StorageService.instance.setLanguageCode(language.id);
    await StorageService.instance.setFlag(language.flag);
  }
}

final StateNotifierProvider<LanguageNotifier, LanguageModel> languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageModel>(
  (StateNotifierProviderRef<LanguageNotifier, LanguageModel> ref) {
    final selectLanguage = ref.watch(languageRepositoryProvder).changeLanguage;
    return LanguageNotifier(ref, callback: selectLanguage);
  },
);

final listLanguageProvider = Provider((ref) => ListLanguages.languages);
