import 'package:cinemapedia/domain/entities/movie.dart';

//TODO: quien llama el origin de datos

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
