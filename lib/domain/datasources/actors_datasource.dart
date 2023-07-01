part of domain.datasources;

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsBymovie(String movieId);
}
