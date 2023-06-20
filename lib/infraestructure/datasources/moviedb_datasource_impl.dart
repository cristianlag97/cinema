import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import '../../config/helpers/dio.dart';
import '../models/models.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDbDataSourceImpl extends MoviesDataSource {
  List<Movie> _jsonToMovies(Map<String, dynamic> response) {
    final movieDBResponse = MovieDbResponse.fromJson(response);
    final List<Movie> movies = movieDBResponse.results
        // .where((movieDB) => movieDB.posterPath != 'no-posterPath')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'language': 'es-MX',
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopulars({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'language': 'es-MX',
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'language': 'es-MX',
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'language': 'es-MX',
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id', queryParameters: {
      'language': 'es-MX',
    });
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);
    final movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (query.isEmpty) return [];

    final response = await dio.get(
      '/search/movie',
      queryParameters: {
        'language': 'es-MX',
        'query': query,
      },
    );
    return _jsonToMovies(response.data);
  }
}
