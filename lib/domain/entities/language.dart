import 'package:flutter/material.dart';

class Language {
  Language({
    required this.id,
    required this.country,
    required this.language,
    required this.flag,
    required this.locale,
  });

  final int id;
  final String country;
  final String language;
  final String flag;
  final Locale locale;
}
