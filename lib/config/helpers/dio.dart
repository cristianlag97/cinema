part of config.helpers;

Dio get dio => Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Enviroment.theMovieDbKey,
          // 'language': 'es-MX'
        },
      ),
    );
