part of domain.repositories;

//TODO: quien llama el origin de datos

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopulars({int page = 1});

  Future<List<Movie>> getUpComming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovie(String query);

  Future<List<Movie>> getSimilarMovies(int movieId);

  Future<List<Video>> getYoutubeVideosById(int movieId);
}
