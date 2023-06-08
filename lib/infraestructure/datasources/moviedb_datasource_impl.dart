import 'package:dio/dio.dart';

import 'package:cinemapedia/config/contans/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import '../models/models.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDbDataSourceImpl extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Enviroment.theMovieDbKey,
      'language': 'es-MX'
    }),
  );

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
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopulars({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie//top_rated',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) async {
    final response = await dio.get(
      '/movie//upcoming',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }
}
