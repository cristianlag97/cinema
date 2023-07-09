import 'package:cinemapedia/domain/domain.dart';

class LanguageModel {
  LanguageModel({
    this.flag,
    this.locale,
  });

  final Language? locale;
  final String? flag;

  LanguageModel copyWith({
    String? flag,
    Language? locale,
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
