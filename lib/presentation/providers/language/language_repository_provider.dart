part of presentation.provider.language;

final languageRepositoryProvder = Provider(
  (ref) => LanguageRepositoryImpl(
    LanguageDatasourceImpl(),
  ),
);
