part of infraestructure.datasource;

class LanguageDatasourceImpl extends LanguageDatasource {
  @override
  Future<Language> changeLanguage(
      BuildContext context, Language language) async {
    final sendLodale = context.supportedLocales[0] == language.locale
        ? context.supportedLocales[0]
        : context.supportedLocales[1];
    await context.setLocale(sendLodale);
    return language;
  }
}
