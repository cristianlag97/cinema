part of domain.repositories;

abstract class LanguageRepository {
  Future<Language> changeLanguage(BuildContext context, Language language);
}
