part of domain.repositories;

abstract class ActorsRepository {
  Future<List<Actor>> getActorsBymovie(String movieId);
}
