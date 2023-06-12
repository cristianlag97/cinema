import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infraestructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia/infraestructure/repositories/movie_repository_impl.dart';

//TODO: Provider de solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDataSourceImpl());
});
