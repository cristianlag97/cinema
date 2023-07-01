part of domain.datasources;

//TODO: origen de datos

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopulars({int page = 1});
  Future<List<Movie>> getUpComming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1, String language});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovie(String query);
}
