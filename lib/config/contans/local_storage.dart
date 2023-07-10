import 'package:cinemapedia/config/contans/enviroment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  static const String _savedLanguage = 'saved_language';
  static const String _savedFlag = 'saved_flag';
  static const String _savedColor = 'saved_color';
  static const String _savedTheme = 'saved_theme';

  Future<void> init() async {
    Enviroment.preferences = await SharedPreferences.getInstance();
  }

  Future<void> setLanguageCode(int value) async {
    await Enviroment.preferences?.setInt(_savedLanguage, value);
  }

  int get getLanguageCode =>
      Enviroment.preferences?.getInt(_savedLanguage) ?? 1;

  Future<void> setFlag(String value) async {
    await Enviroment.preferences?.setString(_savedFlag, value);
  }

  String get getFlag =>
      Enviroment.preferences?.getString(_savedFlag) ??
      'assets/icons/flag-for-usa.svg';

  int get getIndexColor => Enviroment.preferences?.getInt(_savedColor) ?? 0;

  Future<void> setIndexColor(int value) async {
    await Enviroment.preferences?.setInt(_savedColor, value);
  }

  bool get getIsDark => Enviroment.preferences?.getBool(_savedTheme) ?? false;

  Future<void> setIsDark(bool value) async {
    await Enviroment.preferences?.setBool(_savedTheme, value);
  }
}
