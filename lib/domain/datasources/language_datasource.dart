part of domain.datasources;

abstract class LanguageDatasource {
  Future<Language> changeLanguage(BuildContext context, Language language);
}
