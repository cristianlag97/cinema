part of presentation.provider.actors;

//TODO: Provider de solo lectura
final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasourceImpl());
});
