import 'package:cinemapedia/infraestructure/datasources/actor_moviedb_datasource_impl.dart';
import 'package:cinemapedia/infraestructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: Provider de solo lectura
final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasourceImpl());
});
