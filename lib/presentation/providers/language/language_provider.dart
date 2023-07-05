part of presentation.provider.language;

typedef ChangeLanguageCallback = Future<Language> Function(
    BuildContext context, Language language);

class LanguageNotifier extends StateNotifier<LanguageModel> {
  LanguageNotifier({required this.callback}) : super(LanguageModel());

  final ChangeLanguageCallback callback;

  Future<void> initStateLanguage() async {
    final int index = StorageService.instance.getLanguageCode;
    final String flag = StorageService.instance.getFlag;

    state = state.copyWith(
      flag: state.copyWith().flag ?? flag,
      locale: state.copyWith().locale ?? ListLanguages.languages[index].locale,
    );
  }

  void toggleLanguage(BuildContext context, Language language) async {
    final languageSelected = await callback(context, language);
    state = state.copyWith(
      flag: languageSelected.flag,
      locale: languageSelected.locale,
    );
  }
}

final StateNotifierProvider<LanguageNotifier, LanguageModel> languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageModel>(
  (ref) {
    final selectLanguage = ref.watch(languageRepositoryProvder).changeLanguage;
    return LanguageNotifier(callback: selectLanguage);
  },
);

final listLanguageProvider = Provider((ref) => ListLanguages.languages);
