part of presentation.provider.actors;

//TODO: Provider de solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDataSourceImpl());
});
