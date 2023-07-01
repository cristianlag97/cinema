part of infraestructure.repositories;

class ActorRepositoryImpl extends ActorsRepository {
  ActorRepositoryImpl(this.actorsDatasource);

  final ActorsDatasource actorsDatasource;

  @override
  Future<List<Actor>> getActorsBymovie(String movieId) {
    return actorsDatasource.getActorsBymovie(movieId);
  }
}
