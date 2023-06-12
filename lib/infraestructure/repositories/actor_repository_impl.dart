import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  ActorRepositoryImpl(this.actorsDatasource);

  final ActorsDatasource actorsDatasource;

  @override
  Future<List<Actor>> getActorsBymovie(String movieId) {
    return actorsDatasource.getActorsBymovie(movieId);
  }
}
