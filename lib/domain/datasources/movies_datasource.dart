import 'package:cinemapedia/domain/entities/movie.dart';

//TODO: origen de datos

abstract class MovieDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
