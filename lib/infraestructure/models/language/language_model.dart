import 'package:flutter/material.dart';

class LanguageModel {
  LanguageModel({
    this.flag,
    this.locale,
  });

  final Locale? locale;
  final String? flag;

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
