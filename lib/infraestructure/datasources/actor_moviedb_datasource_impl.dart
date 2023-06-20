import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/moviedb.dart';

import '../../config/helpers/dio.dart';

class ActorMovieDbDatasourceImpl extends ActorsDatasource {
  @override
  Future<List<Actor>> getActorsBymovie(String movieId) async {
    final response = await dio
        .get('/movie/$movieId/credits', queryParameters: {'language': 'es-MX'});
    // print(dio.get());
    final responseModel = CreditsResponse.fromJson(response.data);
    final actors = responseModel.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
    return actors;
  }
}
