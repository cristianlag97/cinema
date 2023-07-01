import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infraestructure/infraestructure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<LanguageModel> {
  LanguageNotifier() : super(LanguageModel());

  late LocalizationsDelegate delegate;

  void toggleLanguage(
      BuildContext context, Language language, VoidCallback refresh) async {
    state = state.copyWith(
      flag: language.flag,
      locale: language.locale,
    );
    final sendLodale = context.supportedLocales[0] == language.locale
        ? context.supportedLocales[0]
        : context.supportedLocales[1];
    await context.setLocale(sendLodale);
    refresh;
  }
}

final StateNotifierProvider<LanguageNotifier, LanguageModel> languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageModel>(
  (ref) => LanguageNotifier(),
);

final listLanguageProvider = Provider((ref) => ListLanguages.languages);
