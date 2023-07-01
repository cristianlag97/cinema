part of config.helpers;

class ListLanguages {
  static final List<Language> languages = [
    Language(
      id: 1,
      country: 'CO',
      language: 'es',
      flag: 'assets/icons/flag-for-colombia.svg',
      locale: const Locale('es', 'CO'),
    ),
    Language(
      id: 2,
      country: 'US',
      language: 'en',
      flag: 'assets/icons/flag-for-usa.svg',
      locale: const Locale('en', 'US'),
    )
  ];

  static final all = [
    const Locale('es', 'CO'),
    const Locale('en', 'US'),
  ];
}
