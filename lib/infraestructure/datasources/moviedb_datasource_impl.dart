part of infraestructure.datasource;

class MovieDbDataSourceImpl extends MoviesDataSource {
  List<Movie> _jsonToMovies(Map<String, dynamic> response) {
    final movieDBResponse = MovieDbResponse.fromJson(response);
    final List<Movie> movies = movieDBResponse.results
        // .where((movieDB) => movieDB.posterPath != 'no-posterPath')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();

    return movies;
  }

  String get _language {
    final index = StorageService.instance.getLanguageCode;
    final lang =
        '${ListLanguages.languages[index].language}-${ListLanguages.languages[index].country}';
    return lang;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'language': _language,
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
        'language': _language,
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
        'language': _language,
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
        'language': _language,
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id', queryParameters: {
      'language': _language,
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
        'language': _language,
        'query': query,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get('/movie/$movieId/similar', queryParameters: {
      'language': _language,
    });
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos', queryParameters: {
      'language': _language,
    });
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <Video>[];

    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }
}
