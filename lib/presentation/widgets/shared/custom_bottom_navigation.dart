part of presentation.widget.shared;

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({required this.currentIndex, super.key});

  final int currentIndex;

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);

    return BottomNavigationBar(
        onTap: (int index) => onItemTapped(context, index),
        elevation: 0,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_max), label: 'bottom_nav.home'.tr()),
          BottomNavigationBarItem(
            icon: const Icon(Icons.thumbs_up_down_outlined),
            label: 'bottom_nav.popular'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_outline),
            label: 'bottom_nav.favorite'.tr(),
          ),
        ]);
  }
}
