import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import '../../config/helpers/dio.dart';
import '../models/models.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDbDataSourceImpl extends MoviesDataSource {
  List<Movie> _jsonToMovies(Map<String, dynamic> response) {
    final movieDBResponse = MovieDbResponse.fromJson(response);
    final List<Movie> movies = movieDBResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/now_playing',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopulars({int page = 1}) async {
    final response = await dio.get(
      '/popular',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/top_rated',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) async {
    final response = await dio.get(
      '/upcoming',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);
    final movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
}
