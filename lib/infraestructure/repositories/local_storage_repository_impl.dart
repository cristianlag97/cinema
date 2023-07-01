part of infraestructure.repositories;

class LocalStorageRepositoryImpl extends LocalStoragerepository {
  LocalStorageRepositoryImpl(this.dataSource);

  final LocalStorageDataSource dataSource;

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }
}
