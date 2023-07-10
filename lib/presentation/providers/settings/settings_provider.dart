import 'package:cinemapedia/config/contans/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

final colorListProvider = Provider((ref) => colorList);

final StateNotifierProvider<ThemeNotifier, AppTheme> themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  Future<void> toggleDarkMode() async {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    await StorageService.instance.setIsDark(!state.isDarkMode);
  }

  Future<void> changeColorIndex(int colorIndex) async {
    state = state.copyWith(selectedColor: colorIndex);
    await StorageService.instance.setIndexColor(colorIndex);
  }

  Future<void> initTheme() async {
    state = state.copyWith(
      isDarkMode: StorageService.instance.getIsDark,
      selectedColor: StorageService.instance.getIndexColor,
    );
  }
}
