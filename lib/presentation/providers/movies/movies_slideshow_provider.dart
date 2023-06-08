import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final moviesStateProvider = ref.watch(nowPlayingMoviesProvider);
  if (moviesStateProvider.isEmpty) return [];

  return moviesStateProvider.sublist(0, 6);
});
