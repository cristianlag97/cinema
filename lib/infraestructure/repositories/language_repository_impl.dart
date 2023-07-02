part of infraestructure.repositories;

class LanguageRepositoryImpl extends LanguageRepository {
  LanguageRepositoryImpl(this.languageDatasource);

  final LanguageDatasource languageDatasource;

  @override
  Future<Language> changeLanguage(BuildContext context, Language language) {
    return languageDatasource.changeLanguage(context, language);
  }
}
