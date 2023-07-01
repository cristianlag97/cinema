part of infraestructure.datasource;

class ActorMovieDbDatasourceImpl extends ActorsDatasource {
  @override
  Future<List<Actor>> getActorsBymovie(String movieId) async {
    final response = await dio
        .get('/movie/$movieId/credits', queryParameters: {'language': 'es-MX'});
    final responseModel = CreditsResponse.fromJson(response.data);
    final actors = responseModel.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
    return actors;
  }
}
