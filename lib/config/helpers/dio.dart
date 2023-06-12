import 'package:dio/dio.dart';

import '../contans/enviroment.dart';

Dio get dio => Dio(
      BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3/movie',
          queryParameters: {
            'api_key': Enviroment.theMovieDbKey,
            'language': 'es-MX'
          }),
    );
