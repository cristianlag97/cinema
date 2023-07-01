part of infraestructure.repositories;

class MovieRepositoryImpl extends MoviesRepository {
  MovieRepositoryImpl(this.dataSource);

  final MoviesDataSource dataSource;

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopulars({int page = 1}) {
    return dataSource.getPopulars(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({
    int page = 1,
    String language = 'en-US',
  }) {
    return dataSource.getTopRated(page: page, language: language);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) {
    return dataSource.getUpComming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    return dataSource.searchMovie(query);
  }
}
