import 'package:cinemapedia/config/config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'config/contans/local_storage.dart';
import 'presentation/presentation.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    const ProviderScope(
      child: LocalizationApp(),
    ),
  );
}

class LocalizationApp extends StatelessWidget {
  const LocalizationApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: ListLanguages.all,
      fallbackLocale: ListLanguages.all[1],
      startLocale: ListLanguages.all[1],
      path: 'assets/langs',
      child: const MainApp(),
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  void init() async {
    await StorageService.instance.init();
    await ref.read(languageProvider.notifier).initStateLanguage();
    await ref.read(themeNotifierProvider.notifier).initTheme();
  }

  @override
  Widget build(BuildContext context) {
    final languageState = ref.watch(languageProvider);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: languageState.locale?.locale,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
    );
  }
}
