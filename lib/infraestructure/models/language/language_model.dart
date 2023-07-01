import 'package:flutter/material.dart';

class LanguageModel {
  LanguageModel({
    this.flag = 'assets/icons/flag-for-usa.svg',
    this.locale = const Locale('en', 'US'),
  });

  final Locale locale;
  final String flag;

  LanguageModel copyWith({
    String? flag,
    Locale? locale,
  }) =>
      LanguageModel(
        flag: flag ?? this.flag,
        locale: locale ?? this.locale,
      );

  @override
  String toString() => '''Language selected =>
    flag: $flag,
    locale: $locale,
  ''';
}
