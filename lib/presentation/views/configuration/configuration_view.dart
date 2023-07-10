import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class ConfigurationView extends ConsumerStatefulWidget {
  const ConfigurationView({super.key});

  static const name = 'theme_change_screen';

  @override
  ConsumerState<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends ConsumerState<ConfigurationView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings_page.title'.tr()),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(themeNotifierProvider.notifier).toggleDarkMode(),
            icon: Icon(
              isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            ),
          )
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    final selectedColor = ref.watch(themeNotifierProvider).selectedColor;
    return ListView.builder(
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          final Color color = colors[index];
          return RadioListTile(
            title: Text('settings_page.this_color'.tr(),
                style: TextStyle(color: color)),
            subtitle: Text('${color.value}'),
            activeColor: color,
            value: index,
            groupValue: selectedColor,
            onChanged: (value) => ref
                .read(themeNotifierProvider.notifier)
                .changeColorIndex(index),
          );
        });
  }
}
