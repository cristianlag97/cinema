part of presentation.provider.storage;

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDataSourceImpl());
});

final isFavoriteProvider =
    FutureProvider.family.autoDispose((FutureProviderRef ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});
